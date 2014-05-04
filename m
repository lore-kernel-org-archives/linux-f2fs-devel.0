From: Paul Ni <nikulinpi@gmail.com>
Subject: Segment size
Date: Sun, 4 May 2014 23:59:54 +0000
Message-ID: <CAN3U_kWiD81+cV3JxNhTKvTZFjFtmeCtzmohOTzVxX3+WqdgbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7005783532740412745=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <nikulinpi@gmail.com>) id 1Wh6Ko-0000L5-1m
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 May 2014 00:00:42 +0000
Received: from mail-wg0-f42.google.com ([74.125.82.42])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Wh6Kn-0004t6-4H
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 May 2014 00:00:42 +0000
Received: by mail-wg0-f42.google.com with SMTP id y10so659608wgg.13
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 04 May 2014 17:00:34 -0700 (PDT)
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

--===============7005783532740412745==
Content-Type: multipart/alternative; boundary=001a11c2283a12bfaf04f89bd21f

--001a11c2283a12bfaf04f89bd21f
Content-Type: text/plain; charset=UTF-8

Is it possible to set an arbitrary segment size? I'm trying to set it to
1.5MiB to make it align with erase blocks on flash chips in my EVO 840 SSD.

--001a11c2283a12bfaf04f89bd21f
Content-Type: text/html; charset=UTF-8

<div dir="ltr">Is it possible to set an arbitrary segment size? I&#39;m trying to set it to 1.5MiB to make it align with erase blocks on flash chips in my EVO 840 SSD.<br></div>

--001a11c2283a12bfaf04f89bd21f--


--===============7005783532740412745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--===============7005783532740412745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============7005783532740412745==--
