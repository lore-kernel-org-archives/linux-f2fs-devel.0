Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237F9C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Jun 2022 21:40:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o5wT3-0001o1-64; Mon, 27 Jun 2022 21:40:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <vincent@systemli.org>) id 1o5wSx-0001nl-J0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Jun 2022 21:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lrXzUc0M2h0zs56lBsl9mZ2SmXXlRn6yeaG9Kn32Apc=; b=YDFZBnIAFHjtpShoBWm6INYmD4
 8MvhXMfDgsjNQEzWWMjUZpKR5gXSf77tQe0e2YRHsm+11pUiQHHz/y55qzFJN7Un+wrZEL6Y47+8b
 fC8WjFkNzdG0Rr5HVUAw99KyRv0mQ5auWCSlC/3XxiLArYeSn4qHv+Jzoe363DpIhmnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lrXzUc0M2h0zs56lBsl9mZ2SmXXlRn6yeaG9Kn32Apc=; b=O
 ysavHhWp80/KBcEyTMq9GrSQPK8zFGdcXdM7IiBinyJ9NO1ppDxFAsjpycJWlEzUOaMTbf1M1e+3U
 bb1IWGHNubdEk6dXFWGWhRvpGERCRocFap/X+bfebY2tDH0nNG51QV/h9crBDW82DibVEiIHWcOAG
 6cElqR9786to/dm0=;
Received: from mail1.systemli.org ([93.190.126.36])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o5wSs-00G6Uz-MS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 27 Jun 2022 21:40:19 +0000
From: vincent@systemli.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
 s=default; t=1656366000;
 bh=lrXzUc0M2h0zs56lBsl9mZ2SmXXlRn6yeaG9Kn32Apc=;
 h=From:To:Cc:Subject:Date:From;
 b=6cyUBhIwkr5DNNGyAkqyFhTbzZ8znoCOF6eeMdKzG2aVSeNoYgTQoIHmzENwT6hVp
 jo/D+Ycyx8qqumuvePEzxOTxtMJWf265v4AfAB5CyNUdMT4Wugn4fW0XNFU2i1L4Ee
 77KaZ54KcsA0RmyzRyYXsxFgWteWN6s/EhREi4Pn5IFHGsgvSpb3ct6MJwRUOpPabU
 3rYvB4JVakQTaMSYJVBambYGb3e45dpki0uitEHC/IqY5csxOTHQBccUo5Xsnf817h
 nNulPJvsuhwEB8+x94ZuUoHMnp9xy5mRHbkDxxAxtMZm7YJr4mcBEUUONp53h1gC5U
 Vj1KhS/pq4DMA==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 27 Jun 2022 23:39:47 +0200
Message-Id: <20220627213947.2317-1-vincent@systemli.org>
MIME-Version: 1.0
X-Headers-End: 1o5wSs-00G6Uz-MS
Subject: [f2fs-dev] [PATCH] configure.ac: fix AC_ARG_WITH
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nick Hainke <vincent@systemli.org>

In the new version the configuration no longer respects the
--without/--with blkid/selinux parameters. Add the tests for
"with_blkid" and "with_selinux" back to configure.ac as described
in the manual.

Link: https://www.gnu.org/software/autoconf/manual/autoconf-2.60/html_node/External-Software.html

Fixes: 	c48335416a09 ("configure.ac: Enable cross-compilation")

Signed-off-by: Nick Hainke <vincent@systemli.org>
---
 configure.ac | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 91bf7ff..fbde054 100644
--- a/configure.ac
+++ b/configure.ac
@@ -55,11 +55,17 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
        [$PATH:/sbin])
 
 # Checks for libraries.
-AC_CHECK_LIB([blkid], [blkid_probe_all],
-	[AC_SUBST([libblkid_LIBS], ["-lblkid"])
-		AC_DEFINE([HAVE_LIBBLKID], [1],
-		[Define if you have libblkid])
-	], [], [])
+AS_IF([test "x$with_blkid" != xno],
+	[AC_CHECK_LIB([blkid], [blkid_probe_all],
+		[AC_SUBST([libblkid_LIBS], ["-lblkid"])
+			AC_DEFINE([HAVE_LIBBLKID], [1],
+			[Define if you have libblkid])
+		],
+		[if test "x$with_blkid" != xcheck; then
+			AC_MSG_FAILURE(
+                [--with-blkid was given, but test for blkid failed])
+        fi
+	], -lblkid)])
 
 AC_CHECK_LIB([lzo2], [main],
 	[AC_SUBST([liblzo2_LIBS], ["-llzo2"])
@@ -73,11 +79,17 @@ AC_CHECK_LIB([lz4], [main],
 		[Define if you have liblz4])
 	], [], [])
 
-AC_CHECK_LIB([selinux], [getcon],
-	[AC_SUBST([libselinux_LIBS], ["-lselinux"])
-		AC_DEFINE([HAVE_LIBSELINUX], [1],
-		[Define if you have libselinux])
-	], [], [])
+AS_IF([test "x$with_selinux" != xno],
+	[AC_CHECK_LIB([selinux], [getcon],
+		[AC_SUBST([libselinux_LIBS], ["-lselinux"])
+			AC_DEFINE([HAVE_LIBSELINUX], [1],
+			[Define if you have libselinux])
+		],
+		[if test "x$with_selinux" != xcheck; then
+			AC_MSG_FAILURE(
+				[--with-selinux was given, but test for selinux failed])
+		fi
+	], -lselinux)])
 
 AC_CHECK_LIB([uuid], [uuid_clear],
 	[AC_SUBST([libuuid_LIBS], ["-luuid"])
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
