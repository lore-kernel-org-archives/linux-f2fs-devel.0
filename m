From: John Grub <john.f.grub@gmail.com>
Subject: [bug] writes hanging
Date: Fri, 20 Dec 2013 12:29:15 -0800
Message-ID: <CADbsYN1b-jC85e=N+yH=PJTxOWMNBnGaa6a0cVHEcJQfxtRYOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4568864033505586075=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <john.f.grub@gmail.com>) id 1Vu6hc-0007Ua-1G
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 20:29:44 +0000
Received: from mail-gg0-f193.google.com ([209.85.161.193])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vu6ha-0006E1-5L
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 20:29:43 +0000
Received: by mail-gg0-f193.google.com with SMTP id i1so251817ggn.4
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 20 Dec 2013 12:29:36 -0800 (PST)
Received: from mail-oa0-x230.google.com (mail-oa0-x230.google.com
	[2607:f8b0:4003:c02::230]) by mx.google.com with ESMTPSA id
	c44sm12744020yho.20.2013.12.20.12.29.36
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 20 Dec 2013 12:29:36 -0800 (PST)
Received: by mail-oa0-f48.google.com with SMTP id l6so3383148oag.7
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 20 Dec 2013 12:29:35 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

--===============4568864033505586075==
Content-Type: multipart/alternative; boundary=089e013c6fa0f4612d04edfd22d4

--089e013c6fa0f4612d04edfd22d4
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I can't seem to write larger files on my f2fs mount.
My hardware is an embedded arm platform with an 8GB eMMC nand flash
chip: Golbalscale
D2Plug <http://www.globalscaletechnologies.com/t-d2plugdetails.aspx>
I have two of these pieces of hardware and I see this issue on both of
them. There is no issue when I use ext4.
I am running kernel version 3.13.0-rc4
I've compiled  f2fs-tools from here
http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git @
11d187cdfa2dcf504aa25b5a1aab4228f19f22ff

I've followed the installation and usage instructions in
linux/Documentation/filesystems/f2fs.txt to format my 8GB eMMC nand flash
as f2fs.

I'm getting freezes when writing larger files to my f2fs partition. Here is
an experiment I've done to show this.
First create 3 test files of different sizes:
# cat /dev/urandom | head -c 50k > /tmp/50k
# cat /dev/urandom | head -c 100k > /tmp/100k
# cat /dev/urandom | head -c 150k > /tmp/150k

Test case #1: Repeatedly copy the same 50k file to j2fs:
# cp /tmp/50k /mnt/j2fs/ <-- this copy always works fine
# cp /tmp/50k /mnt/j2fs/ <-- this copy always works fine
# cp /tmp/50k /mnt/j2fs/ <-- this copy always hangs forever
For the failing copy, I've seen 4k, 8k and 12k copied correctly before it
stops.

Test case #2: Repeatedly copy the same 100k file to f2fs:
# cp /tmp/100k /mnt/f2fs/ <-- this copy works fine
# cp /tmp/100k /mnt/f2fs/ <-- this copy hangs forever
For the failing copy, I've seen 4k, 8k and 12k copied correctly before it
stops.

Test case #3: Copy a 150k file to f2fs:
# cp /tmp/150k /mnt/f2fs/
This never completes and will hang forever if I don't kill it. It always
seems to fail at 120k.

Any help would be appreciated.

Thanks,
John Grub

--089e013c6fa0f4612d04edfd22d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br><div>I can&#39;t seem to write larger files=
 on my f2fs mount.</div><div>My hardware is an embedded arm platform with a=
n 8GB eMMC nand flash chip: <a href=3D"http://www.globalscaletechnologies.c=
om/t-d2plugdetails.aspx">Golbalscale D2Plug</a></div>

<div>I have two of these pieces of hardware and I see this issue on both of=
 them. There is no issue when I use ext4.</div><div>I am running kernel ver=
sion 3.13.0-rc4</div>I&#39;ve compiled =A0f2fs-tools from here <a href=3D"h=
ttp://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git">http://g=
it.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git</a> @ 11d187cdfa=
2dcf504aa25b5a1aab4228f19f22ff<div>

<br></div><div>I&#39;ve followed the installation and usage instructions in=
 linux/Documentation/filesystems/f2fs.txt to format my 8GB eMMC nand flash =
as f2fs.</div><div><br></div><div>I&#39;m getting freezes when writing larg=
er files to my f2fs partition. Here is an experiment I&#39;ve done to show =
this.</div>

<div>First create 3 test files of different sizes:</div><div># cat /dev/ura=
ndom | head -c 50k &gt; /tmp/50k</div><div># cat /dev/urandom | head -c 100=
k &gt; /tmp/100k<br></div><div># cat /dev/urandom | head -c 150k &gt; /tmp/=
150k<br>

</div><div><br></div><div>Test case #1: Repeatedly copy the same 50k file t=
o j2fs:</div><div># cp /tmp/50k /mnt/j2fs/ &lt;-- this copy always works fi=
ne</div><div># cp /tmp/50k /mnt/j2fs/ &lt;-- this copy always=A0works fine<=
/div>

<div># cp /tmp/50k /mnt/j2fs/ &lt;-- this copy always=A0hangs forever</div>=
<div>For the failing copy, I&#39;ve seen 4k, 8k and 12k copied correctly be=
fore it stops.</div><div><br></div><div><div>Test case #2: Repeatedly copy =
the same 100k file to f2fs:</div>

<div># cp /tmp/100k /mnt/f2fs/ &lt;-- this copy works fine</div><div># cp /=
tmp/100k /mnt/f2fs/ &lt;-- this copy hangs forever<br></div></div><div>For =
the failing copy, I&#39;ve seen 4k, 8k and 12k copied correctly before it s=
tops.<br>

</div><div><br></div><div><div><div>Test case #3: Copy a 150k file to f2fs:=
</div><div># cp /tmp/150k /mnt/f2fs/<br></div></div><div>This never complet=
es and will hang forever if I don&#39;t kill it. It always seems to fail at=
 120k.<br>

</div></div><div><br></div><div>Any help would be appreciated.</div></div><=
div><br></div><div>Thanks,</div><div>John Grub</div></div>

--089e013c6fa0f4612d04edfd22d4--


--===============4568864033505586075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============4568864033505586075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============4568864033505586075==--
