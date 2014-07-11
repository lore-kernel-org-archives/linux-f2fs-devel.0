From: =?UTF-8?Q?Petar_Koreti=C4=87?= <petar.koretic@gmail.com>
Subject: [f2fs.fsck] status report show fails
Date: Fri, 11 Jul 2014 23:18:10 +0200
Message-ID: <CAOWmdGMyHzm2exVPKi7Gd1EZc9vKtVQV8W92=2H=nR6HCH7Tew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5397395203638662697=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <petar.koretic@gmail.com>) id 1X5iCw-0003pg-KC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Jul 2014 21:18:18 +0000
Received: from mail-lb0-f177.google.com ([209.85.217.177])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1X5iCv-0007Pq-PW
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Jul 2014 21:18:18 +0000
Received: by mail-lb0-f177.google.com with SMTP id u10so1298242lbd.36
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 11 Jul 2014 14:18:11 -0700 (PDT)
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

--===============5397395203638662697==
Content-Type: multipart/alternative; boundary=001a11c3353681dec004fdf17a0d

--001a11c3353681dec004fdf17a0d
Content-Type: text/plain; charset=UTF-8

Hi guys.

I've been using f2fs on my primary SSD disk and laptop from April 17, 2013.

I really didn't have any problems but lately I've started to see some.
For example, data is not being saved or after reboot old data is loaded.
I haven't really taken a deeper look into it yet but that's not directly
why I'm posting.

Today I finally run fsck. In the output I got all fails except:
---------------------------------------------------------------------
[FSCK] Hard link checking for regular file
---------------------------------------------------------------------
which was the only one with '[Ok...]' status.

As far as I know and can see from git logs fsck
doesn't yet have ability to fix problems.

Just to mention currently I have it mounted with:
rw,relatime,discard,background_gc=off,noacl,nouser_xattr

So what are these fails telling me and what
are my options?

Thanks,
Petar

--001a11c3353681dec004fdf17a0d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi guys.<div><br></div><div>I&#39;ve been using f2fs on my=
 primary SSD disk and laptop from April 17, 2013.</div><div><br></div><div>=
I really didn&#39;t have any problems but lately I&#39;ve started to see so=
me.</div>
<div>For example, data is not being saved or after reboot old data is loade=
d.</div><div>I haven&#39;t really taken a deeper look into it yet but that&=
#39;s not directly why I&#39;m posting.</div><div><br></div><div>Today I fi=
nally run fsck. In the output I got all fails except:</div>
<div>---------------------------------------------------------------------<=
/div><div>[FSCK] Hard link checking for regular file</div><div>------------=
---------------------------------------------------------</div><div>which w=
as the only one with &#39;[Ok...]&#39; status.</div>
<div><br></div><div>As far as I know and can see from git logs fsck</div><d=
iv>doesn&#39;t yet have ability to fix problems.</div><div><br></div><div>J=
ust to mention currently I have it mounted with:</div><div>rw,relatime,disc=
ard,background_gc=3Doff,noacl,nouser_xattr</div>
<div><br></div><div>So what are these fails telling me and what</div><div>a=
re my options?</div><div><br></div><div>Thanks,</div><div>Petar</div></div>

--001a11c3353681dec004fdf17a0d--


--===============5397395203638662697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5397395203638662697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============5397395203638662697==--
