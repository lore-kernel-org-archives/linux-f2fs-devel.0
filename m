From: John Grub <john.f.grub@gmail.com>
Subject: Re: [bug] writes hanging
Date: Mon, 23 Dec 2013 20:28:58 -0800
Message-ID: <CADbsYN3+p4Bs_=++p-bq=pSSKiqq0p3MNamSufQvFU9fxjVx+g@mail.gmail.com>
References: <CADbsYN1b-jC85e=N+yH=PJTxOWMNBnGaa6a0cVHEcJQfxtRYOw@mail.gmail.com>
	<1387761237.2101.284.camel@kjgkr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0520576651835192137=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <john.f.grub@gmail.com>) id 1VvJcV-0004K9-NN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Dec 2013 04:29:27 +0000
Received: from mail-yh0-f49.google.com ([209.85.213.49])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VvJcU-00042z-CW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Dec 2013 04:29:27 +0000
Received: by mail-yh0-f49.google.com with SMTP id z20so1366140yhz.22
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 23 Dec 2013 20:29:21 -0800 (PST)
Received: from mail-ob0-x234.google.com (mail-ob0-x234.google.com
	[2607:f8b0:4003:c01::234])
	by mx.google.com with ESMTPSA id q9sm29503144yhk.16.2013.12.23.20.29.20
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 23 Dec 2013 20:29:20 -0800 (PST)
Received: by mail-ob0-f180.google.com with SMTP id wo20so6164604obc.25
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 23 Dec 2013 20:29:19 -0800 (PST)
In-Reply-To: <1387761237.2101.284.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: John Grub <john.f.grub@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

--===============0520576651835192137==
Content-Type: multipart/alternative; boundary=089e0111b45423fb4404ee403047

--089e0111b45423fb4404ee403047
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Today I updated my kernel to 3.13.0-rc5 with a minimal set of config flags
and the problem has disappeared. So it's either been fixed by rc5 or I had
some kernel config conflict that caused the issue (probably the latter). In
any case, the problem is solved. Thank you for looking into it.



On Sun, Dec 22, 2013 at 5:13 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com>wrote=
:

> Hi,
>
> I couldn't get any error when replaying your scenario on my arm board.
> So, could you send the backtrace of any hanged process?
>
> # cat /proc/[pid]/stack
>
> Thanks,
>
> 2013-12-20 (=EA=B8=88), 12:29 -0800, John Grub:
> > Hello,
> >
> > I can't seem to write larger files on my f2fs mount.
> > My hardware is an embedded arm platform with an 8GB eMMC nand flash
> > chip: Golbalscale D2Plug
> > I have two of these pieces of hardware and I see this issue on both of
> > them. There is no issue when I use ext4.
> > I am running kernel version 3.13.0-rc4
> > I've compiled  f2fs-tools from here
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git @
> > 11d187cdfa2dcf504aa25b5a1aab4228f19f22ff
> >
> >
> > I've followed the installation and usage instructions in
> > linux/Documentation/filesystems/f2fs.txt to format my 8GB eMMC nand
> > flash as f2fs.
> >
> >
> > I'm getting freezes when writing larger files to my f2fs partition.
> > Here is an experiment I've done to show this.
> > First create 3 test files of different sizes:
> > # cat /dev/urandom | head -c 50k > /tmp/50k
> > # cat /dev/urandom | head -c 100k > /tmp/100k
> >
> > # cat /dev/urandom | head -c 150k > /tmp/150k
> >
> >
> >
> > Test case #1: Repeatedly copy the same 50k file to j2fs:
> > # cp /tmp/50k /mnt/j2fs/ <-- this copy always works fine
> > # cp /tmp/50k /mnt/j2fs/ <-- this copy always works fine
> > # cp /tmp/50k /mnt/j2fs/ <-- this copy always hangs forever
> > For the failing copy, I've seen 4k, 8k and 12k copied correctly before
> > it stops.
> >
> >
> > Test case #2: Repeatedly copy the same 100k file to f2fs:
> > # cp /tmp/100k /mnt/f2fs/ <-- this copy works fine
> > # cp /tmp/100k /mnt/f2fs/ <-- this copy hangs forever
> >
> > For the failing copy, I've seen 4k, 8k and 12k copied correctly before
> > it stops.
> >
> >
> >
> > Test case #3: Copy a 150k file to f2fs:
> > # cp /tmp/150k /mnt/f2fs/
> >
> > This never completes and will hang forever if I don't kill it. It
> > always seems to fail at 120k.
> >
> >
> >
> > Any help would be appreciated.
> >
> >
> > Thanks,
> > John Grub
> >
> -------------------------------------------------------------------------=
-----
> > Rapidly troubleshoot problems before they affect your business. Most IT
> > organizations don't have a clear picture of how application performance
> > affects their revenue. With AppDynamics, you get 100% visibility into
> your
> > Java,.NET, & PHP application. Start your 15-day FREE TRIAL of
> AppDynamics Pro!
> >
> http://pubads.g.doubleclick.net/gampad/clk?id=3D84349831&iu=3D/4140/ostg.=
clktrk
> > _______________________________________________ Linux-f2fs-devel mailin=
g
> list Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> --
> Jaegeuk Kim
> Samsung
>
>

--089e0111b45423fb4404ee403047
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Today I updated my kernel to=C2=A0<font face=3D"arial, san=
s-serif">3.13.0-rc5 with a minimal set of config flags and the problem has=
=C2=A0disappeared. So it&#39;s either been fixed by rc5 or I had some kerne=
l config conflict that caused the issue (probably the latter). In any case,=
 the problem is solved. Thank you for looking into it.</font><div>

<font face=3D"arial, sans-serif"><br></font></div></div><div class=3D"gmail=
_extra"><br><br><div class=3D"gmail_quote">On Sun, Dec 22, 2013 at 5:13 PM,=
 Jaegeuk Kim <span dir=3D"ltr">&lt;<a href=3D"mailto:jaegeuk.kim@samsung.co=
m" target=3D"_blank">jaegeuk.kim@samsung.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
I couldn&#39;t get any error when replaying your scenario on my arm board.<=
br>
So, could you send the backtrace of any hanged process?<br>
<br>
# cat /proc/[pid]/stack<br>
<br>
Thanks,<br>
<br>
2013-12-20 (=EA=B8=88), 12:29 -0800, John Grub:<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; Hello,<br>
&gt;<br>
&gt; I can&#39;t seem to write larger files on my f2fs mount.<br>
&gt; My hardware is an embedded arm platform with an 8GB eMMC nand flash<br=
>
&gt; chip: Golbalscale D2Plug<br>
&gt; I have two of these pieces of hardware and I see this issue on both of=
<br>
&gt; them. There is no issue when I use ext4.<br>
&gt; I am running kernel version 3.13.0-rc4<br>
&gt; I&#39;ve compiled =C2=A0f2fs-tools from here<br>
&gt; <a href=3D"http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-to=
ols.git" target=3D"_blank">http://git.kernel.org/cgit/linux/kernel/git/jaeg=
euk/f2fs-tools.git</a> @<br>
&gt; 11d187cdfa2dcf504aa25b5a1aab4228f19f22ff<br>
&gt;<br>
&gt;<br>
&gt; I&#39;ve followed the installation and usage instructions in<br>
&gt; linux/Documentation/filesystems/f2fs.txt to format my 8GB eMMC nand<br=
>
&gt; flash as f2fs.<br>
&gt;<br>
&gt;<br>
&gt; I&#39;m getting freezes when writing larger files to my f2fs partition=
.<br>
&gt; Here is an experiment I&#39;ve done to show this.<br>
&gt; First create 3 test files of different sizes:<br>
&gt; # cat /dev/urandom | head -c 50k &gt; /tmp/50k<br>
&gt; # cat /dev/urandom | head -c 100k &gt; /tmp/100k<br>
&gt;<br>
&gt; # cat /dev/urandom | head -c 150k &gt; /tmp/150k<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Test case #1: Repeatedly copy the same 50k file to j2fs:<br>
&gt; # cp /tmp/50k /mnt/j2fs/ &lt;-- this copy always works fine<br>
&gt; # cp /tmp/50k /mnt/j2fs/ &lt;-- this copy always works fine<br>
&gt; # cp /tmp/50k /mnt/j2fs/ &lt;-- this copy always hangs forever<br>
&gt; For the failing copy, I&#39;ve seen 4k, 8k and 12k copied correctly be=
fore<br>
&gt; it stops.<br>
&gt;<br>
&gt;<br>
&gt; Test case #2: Repeatedly copy the same 100k file to f2fs:<br>
&gt; # cp /tmp/100k /mnt/f2fs/ &lt;-- this copy works fine<br>
&gt; # cp /tmp/100k /mnt/f2fs/ &lt;-- this copy hangs forever<br>
&gt;<br>
&gt; For the failing copy, I&#39;ve seen 4k, 8k and 12k copied correctly be=
fore<br>
&gt; it stops.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Test case #3: Copy a 150k file to f2fs:<br>
&gt; # cp /tmp/150k /mnt/f2fs/<br>
&gt;<br>
&gt; This never completes and will hang forever if I don&#39;t kill it. It<=
br>
&gt; always seems to fail at 120k.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Any help would be appreciated.<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt; John Grub<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">&gt; ------------------=
------------------------------------------------------------<br>
&gt; Rapidly troubleshoot problems before they affect your business. Most I=
T<br>
&gt; organizations don&#39;t have a clear picture of how application perfor=
mance<br>
&gt; affects their revenue. With AppDynamics, you get 100% visibility into =
your<br>
&gt; Java,.NET, &amp; PHP application. Start your 15-day FREE TRIAL of AppD=
ynamics Pro!<br>
&gt; <a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D84349831&am=
p;iu=3D/4140/ostg.clktrk" target=3D"_blank">http://pubads.g.doubleclick.net=
/gampad/clk?id=3D84349831&amp;iu=3D/4140/ostg.clktrk</a><br>
&gt; _______________________________________________ Linux-f2fs-devel maili=
ng list <a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2f=
s-devel@lists.sourceforge.net</a> <a href=3D"https://lists.sourceforge.net/=
lists/listinfo/linux-f2fs-devel" target=3D"_blank">https://lists.sourceforg=
e.net/lists/listinfo/linux-f2fs-devel</a><br>


<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Jaegeuk Kim<br>
Samsung<br>
<br>
</font></span></blockquote></div><br></div>

--089e0111b45423fb4404ee403047--


--===============0520576651835192137==
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
--===============0520576651835192137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============0520576651835192137==--
