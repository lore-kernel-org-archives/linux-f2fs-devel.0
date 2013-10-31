From: Zachary <zacharyw09264@gmail.com>
Subject: Re: F2FS Superblock Locations
Date: Wed, 30 Oct 2013 23:33:58 -0400
Message-ID: <CAECMkcNNSm3V0h9RHCZMpzPth_yhKaRap7_uoB55Hu6RWu_9Kw@mail.gmail.com>
References: <CAECMkcPVofeNqT=9jYp5arM5_EikERojWdj+tEqKzecWh4nZRg@mail.gmail.com>
	<1383184550.14041.29.camel@kjgkr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9067013802068211812=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zacharyw09264@gmail.com>) id 1Vbj1J-0007a1-Ej
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 03:34:05 +0000
Received: from mail-oa0-f51.google.com ([209.85.219.51])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vbj1I-0000I1-F8
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Oct 2013 03:34:05 +0000
Received: by mail-oa0-f51.google.com with SMTP id h1so2497751oag.10
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 30 Oct 2013 20:33:59 -0700 (PDT)
In-Reply-To: <1383184550.14041.29.camel@kjgkr>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

--===============9067013802068211812==
Content-Type: multipart/alternative; boundary=089e01228000c64d0904ea011ebd

--089e01228000c64d0904ea011ebd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This was in reference to software mistakes that might wipe portions of the
disk rather than hardware failures, it came up after I almost had one
though it turns out its an unrelated problem.
On Oct 30, 2013 9:56 PM, "Jaegeuk Kim" <jaegeuk.kim@samsung.com> wrote:

> Hi,
>
> 2013-10-30 (=EC=88=98), 21:06 -0400, Zachary:
> > Hello,
> >
> > Recently I was checking the file format for F2FS and noticed that the
> > superblocks' location on the partition was both at the beginning.
> > This means that if a large portion of the partition is corrupted, then
> > it is possible for both superblocks to be destroyed.  From my
> > understanding of other filesystems, they prevent that by spreading out
> > the superbolock backups across the partition so that it reduces the
> > chances of all superblocks being destroyed.  Has this been noticed
> > before or am I mistaken in some way?
>
> IMHO, traditional rotational disks like HDDs need such the superblock
> backups.
>
> But for the solid-state disks like SSDs and eMMCs, I suspect that the
> backups are needed in practical, since its firmware, FTL, spreads the
> data across the whole NAND arrays to avoid cell errors (e.g., wear-out).
> So I think the superblock is very much hard to be broken especially on
> flash storages.
>
> Thank you,
>
>
> --
> Jaegeuk Kim
> Samsung
>
>

--089e01228000c64d0904ea011ebd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">This was in reference to software mistakes that might wipe p=
ortions of the disk rather than hardware failures, it came up after I almos=
t had one though it turns out its an unrelated problem.</p>
<div class=3D"gmail_quote">On Oct 30, 2013 9:56 PM, &quot;Jaegeuk Kim&quot;=
 &lt;<a href=3D"mailto:jaegeuk.kim@samsung.com">jaegeuk.kim@samsung.com</a>=
&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi,<br>
<br>
2013-10-30 (=EC=88=98), 21:06 -0400, Zachary:<br>
&gt; Hello,<br>
&gt;<br>
&gt; Recently I was checking the file format for F2FS and noticed that the<=
br>
&gt; superblocks&#39; location on the partition was both at the beginning.<=
br>
&gt; This means that if a large portion of the partition is corrupted, then=
<br>
&gt; it is possible for both superblocks to be destroyed. =C2=A0From my<br>
&gt; understanding of other filesystems, they prevent that by spreading out=
<br>
&gt; the superbolock backups across the partition so that it reduces the<br=
>
&gt; chances of all superblocks being destroyed. =C2=A0Has this been notice=
d<br>
&gt; before or am I mistaken in some way?<br>
<br>
IMHO, traditional rotational disks like HDDs need such the superblock<br>
backups.<br>
<br>
But for the solid-state disks like SSDs and eMMCs, I suspect that the<br>
backups are needed in practical, since its firmware, FTL, spreads the<br>
data across the whole NAND arrays to avoid cell errors (e.g., wear-out).<br=
>
So I think the superblock is very much hard to be broken especially on<br>
flash storages.<br>
<br>
Thank you,<br>
<br>
<br>
--<br>
Jaegeuk Kim<br>
Samsung<br>
<br>
</blockquote></div>

--089e01228000c64d0904ea011ebd--


--===============9067013802068211812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
--===============9067013802068211812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============9067013802068211812==--
