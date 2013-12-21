From: Chris Fries <ccfries@gmail.com>
Subject: Re: [bug] writes hanging
Date: Sat, 21 Dec 2013 15:06:33 -0600
Message-ID: <CAGC=Z9Qk4StsjgKbY_PZ7y_3zDoowGx5FKCWTrHc2m6KZOq7Wg@mail.gmail.com>
References: <CADbsYN1b-jC85e=N+yH=PJTxOWMNBnGaa6a0cVHEcJQfxtRYOw@mail.gmail.com>
	<CADbsYN3vxdOMGjQ_iO_yvfkowfFwSrLjeY=XnGnKr-0iV0ad9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1569550805186581202=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccfries@gmail.com>) id 1VuTku-0005aM-QG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Dec 2013 21:06:40 +0000
Received: from mail-ob0-f182.google.com ([209.85.214.182])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VuTkt-0001Ax-PN
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 21 Dec 2013 21:06:40 +0000
Received: by mail-ob0-f182.google.com with SMTP id wp4so4152687obc.13
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 21 Dec 2013 13:06:34 -0800 (PST)
In-Reply-To: <CADbsYN3vxdOMGjQ_iO_yvfkowfFwSrLjeY=XnGnKr-0iV0ad9Q@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: John Grub <john.f.grub@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

--===============1569550805186581202==
Content-Type: multipart/alternative; boundary=047d7b604cbc07daa304ee11c5b2

--047d7b604cbc07daa304ee11c5b2
Content-Type: text/plain; charset=ISO-8859-1

Anything show up in the kernel log from the block device?  You might try
turning off discard, see if that helps.
On Dec 21, 2013 2:16 PM, "John Grub" <john.f.grub@gmail.com> wrote:

> Note: this is on a M8G2FA Samsung flash chip.
>
>
> On Fri, Dec 20, 2013 at 12:29 PM, John Grub <john.f.grub@gmail.com> wrote:
>
>> Hello,
>>
>> I can't seem to write larger files on my f2fs mount.
>> My hardware is an embedded arm platform with an 8GB eMMC nand flash chip: Golbalscale
>> D2Plug <http://www.globalscaletechnologies.com/t-d2plugdetails.aspx>
>> I have two of these pieces of hardware and I see this issue on both of
>> them. There is no issue when I use ext4.
>> I am running kernel version 3.13.0-rc4
>> I've compiled  f2fs-tools from here
>> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git @
>> 11d187cdfa2dcf504aa25b5a1aab4228f19f22ff
>>
>> I've followed the installation and usage instructions in
>> linux/Documentation/filesystems/f2fs.txt to format my 8GB eMMC nand flash
>> as f2fs.
>>
>> I'm getting freezes when writing larger files to my f2fs partition. Here
>> is an experiment I've done to show this.
>> First create 3 test files of different sizes:
>> # cat /dev/urandom | head -c 50k > /tmp/50k
>> # cat /dev/urandom | head -c 100k > /tmp/100k
>> # cat /dev/urandom | head -c 150k > /tmp/150k
>>
>> Test case #1: Repeatedly copy the same 50k file to j2fs:
>> # cp /tmp/50k /mnt/j2fs/ <-- this copy always works fine
>> # cp /tmp/50k /mnt/j2fs/ <-- this copy always works fine
>> # cp /tmp/50k /mnt/j2fs/ <-- this copy always hangs forever
>> For the failing copy, I've seen 4k, 8k and 12k copied correctly before it
>> stops.
>>
>> Test case #2: Repeatedly copy the same 100k file to f2fs:
>> # cp /tmp/100k /mnt/f2fs/ <-- this copy works fine
>> # cp /tmp/100k /mnt/f2fs/ <-- this copy hangs forever
>> For the failing copy, I've seen 4k, 8k and 12k copied correctly before it
>> stops.
>>
>> Test case #3: Copy a 150k file to f2fs:
>> # cp /tmp/150k /mnt/f2fs/
>> This never completes and will hang forever if I don't kill it. It always
>> seems to fail at 120k.
>>
>> Any help would be appreciated.
>>
>> Thanks,
>> John Grub
>>
>
>
>
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics
> Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
>

--047d7b604cbc07daa304ee11c5b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Anything show up in the kernel log from the block device?=A0=
 You might try turning off discard, see if that helps.</p>
<div class=3D"gmail_quote">On Dec 21, 2013 2:16 PM, &quot;John Grub&quot; &=
lt;<a href=3D"mailto:john.f.grub@gmail.com">john.f.grub@gmail.com</a>&gt; w=
rote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div dir=3D"ltr">Note: this is on a M8G2FA Samsung flash chip.<br></div><di=
v class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Dec 20, =
2013 at 12:29 PM, John Grub <span dir=3D"ltr">&lt;<a href=3D"mailto:john.f.=
grub@gmail.com" target=3D"_blank">john.f.grub@gmail.com</a>&gt;</span> wrot=
e:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hello,<div><br><div>I can&#=
39;t seem to write larger files on my f2fs mount.</div><div>My hardware is =
an embedded arm platform with an 8GB eMMC nand flash chip: <a href=3D"http:=
//www.globalscaletechnologies.com/t-d2plugdetails.aspx" target=3D"_blank">G=
olbalscale D2Plug</a></div>



<div>I have two of these pieces of hardware and I see this issue on both of=
 them. There is no issue when I use ext4.</div><div>I am running kernel ver=
sion 3.13.0-rc4</div>I&#39;ve compiled =A0f2fs-tools from here <a href=3D"h=
ttp://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git" target=
=3D"_blank">http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.=
git</a> @ 11d187cdfa2dcf504aa25b5a1aab4228f19f22ff<div>



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
</blockquote></div><br></div>
<br>-----------------------------------------------------------------------=
-------<br>
Rapidly troubleshoot problems before they affect your business. Most IT<br>
organizations don&#39;t have a clear picture of how application performance=
<br>
affects their revenue. With AppDynamics, you get 100% visibility into your<=
br>
Java,.NET, &amp; PHP application. Start your 15-day FREE TRIAL of AppDynami=
cs Pro!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D84349831&amp;iu=
=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net/gam=
pad/clk?id=3D84349831&amp;iu=3D/4140/ostg.clktrk</a><br>___________________=
____________________________<br>

Linux-f2fs-devel mailing list<br>
<a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2fs-devel@=
lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel" t=
arget=3D"_blank">https://lists.sourceforge.net/lists/listinfo/linux-f2fs-de=
vel</a><br>
<br></blockquote></div>

--047d7b604cbc07daa304ee11c5b2--


--===============1569550805186581202==
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
--===============1569550805186581202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============1569550805186581202==--
