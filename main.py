import discord, asyncio
import pandas as pd
from discord.ext import commands, tasks
from datetime import datetime
from dotenv import load_dotenv

load_dotenv(override=True)
import logging
import os

TOKEN = os.getenv("TOKEN")
CHANNEL_ID = os.getenv("CHANNEL_ID")
send_time='21:37'

intents = discord.Intents.all()
intents.message_content = True

client = discord.Client(intents=intents)
    
    
# @tasks.loop(minutes=1)
# async def test():
#     await client.wait_until_ready()
#     channel = client.get_channel(int(CHANNEL_ID))
#     await channel.send("test toutes les minutes")

async def time_check():
    await client.wait_until_ready()
    message_channel=client.get_channel(int(CHANNEL_ID))
    while not client.is_closed:
        now=datetime.strftime(datetime.now(),'%H:%M')
        if now.hour() == 21 and now.minute() == 40:
            message= 'Bienvenue les coco'
            await message_channel.send(message)
            time=90
        else:
            time=1
        await asyncio.sleep(time)




@client.event
async def on_ready():
    print(f"We have logged in as {client.user}")
    client.loop.create_task(time_check())
    # test.start()



@client.event
async def on_message(message):
    if message.author == client.user:
        return

    if message.content.startswith("$hello"):
        await message.channel.send("Hello!")

    if message.content.startswith("!test"):
        await message.channel.send(f"Hello! welcome to best team, MVP")

    if message.content.startswith("!tod"):
        list_members = []
        list_members_with_power = []
        f1 = []
        for guild in client.guilds:
            async for member in guild.fetch_members(limit=150):
                unlisted = ["MEE6", "MVP-BOT", "Rythm"]
                try:
                    s = member.nick
                    s.find("F1")
                    if member.name not in unlisted and "F1" in member.nick:
                        list_members.append(member.name)
                        list_members_with_power.append(member.nick)
                        f1.append(s[s.find("F1") + 3 :])
                        df_members = pd.Series(list_members)
                        df_members_with_power = pd.Series(list_members_with_power)
                        frame = {
                            "members": df_members,
                            "nickname": df_members_with_power,
                            "f1": f1,
                        }
                        df = pd.DataFrame(frame)
                        df = df.sort_values(by=["f1"], ascending=False)
                except Exception:
                    print("pas de F1 trouvé")
        for i in range(0, len(df), 2):
            await message.channel.send(f"TEAM : {i}")
            await message.channel.send(f"{df.iloc[i:i+2]}")


client.run(TOKEN)
