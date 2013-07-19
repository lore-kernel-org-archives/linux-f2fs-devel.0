From: Kim Jaegeuk <jaegeuk.kim@gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: update file name in the inode block
	during f2fs_rename
Date: Fri, 19 Jul 2013 12:40:47 +0900
Message-ID: <CAOtxgyetWtucBEQJmCU0nLNk9_r42yQSC1+X1i+iHM18rDge+Q@mail.gmail.com>
References: <1374138684-28520-1-git-send-email-jaegeuk.kim@samsung.com>
	<20130718092211.GA4165@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0581013142714920197=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@gmail.com>) id 1V01Ys-0005dM-8F
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Jul 2013 03:40:54 +0000
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V01Yr-0006CE-7B
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Jul 2013 03:40:54 +0000
Received: by mail-pb0-f41.google.com with SMTP id rp16so3932625pbb.14
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 18 Jul 2013 20:40:47 -0700 (PDT)
In-Reply-To: <20130718092211.GA4165@ZenIV.linux.org.uk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

--===============0581013142714920197==
Content-Type: multipart/alternative; boundary=047d7b2ed23b9d997104e1d51745

--047d7b2ed23b9d997104e1d51745
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable

Hi,

2013. 7. 18. =BF=C0=C8=C4 6:22=BF=A1 "Al Viro" <viro@zeniv.linux.org.uk>=B4=
=D4=C0=CC =C0=DB=BC=BA:
>
> On Thu, Jul 18, 2013 at 06:11:23PM +0900, Jaegeuk Kim wrote:
> > The error is reproducible by:
> >
> > After this, when we retrieve the inode->i_name of test2 by dump.f2fs,
we get
> > test1 instead of test2.
> > This is because f2fs didn't update the file name during the f2fs_rename=
.
>
> Er...  Correct me if I'm wrong, but f2fs appears to support link(2) and
> if rename(2) creates some problem for dump.f2fs, I would expect an
> equivalent link()+unlink() combination to do the same...

Right. I will check that too.
Thank you. :)

> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--047d7b2ed23b9d997104e1d51745
Content-Type: text/html; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi,</p>
<p dir=3D"ltr">2013. 7. 18. =BF=C0=C8=C4 6:22=BF=A1 &quot;Al Viro&quot; &lt=
;<a href=3D"mailto:viro@zeniv.linux.org.uk">viro@zeniv.linux.org.uk</a>&gt;=
=B4=D4=C0=CC =C0=DB=BC=BA:<br>
&gt;<br>
&gt; On Thu, Jul 18, 2013 at 06:11:23PM +0900, Jaegeuk Kim wrote:<br>
&gt; &gt; The error is reproducible by:<br>
&gt; &gt;<br>
&gt; &gt; After this, when we retrieve the inode-&gt;i_name of test2 by dum=
p.f2fs, we get<br>
&gt; &gt; test1 instead of test2.<br>
&gt; &gt; This is because f2fs didn&#39;t update the file name during the f=
2fs_rename.<br>
&gt;<br>
&gt; Er... &nbsp;Correct me if I&#39;m wrong, but f2fs appears to support l=
ink(2) and<br>
&gt; if rename(2) creates some problem for dump.f2fs, I would expect an<br>
&gt; equivalent link()+unlink() combination to do the same...</p>
<p dir=3D"ltr">Right. I will check that too.<br>
Thank you. :)</p>
<p dir=3D"ltr">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-f=
sdevel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at &nbsp;<a href=3D"http://vger.kernel.org/majordo=
mo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
</p>

--047d7b2ed23b9d997104e1d51745--


--===============0581013142714920197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
--===============0581013142714920197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============0581013142714920197==--
