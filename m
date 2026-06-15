Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C21CD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d+8Yr66kQ0cq/3BTO28ThPP0Ui3KhUuhKAR3rwy09sE=; b=LnaW+7FTEfQ+AgWcnJ65LPc5sh
	yxxgp/nknJznnslFpiBj8cnku1GlHbdXrOiGxg6VwKKR3YKGwTPFzj8VCmBUj4iQAbQqgPuJsAkbc
	Qphh/MLBLnSJ+6ZDhU7Mbz21e7/T3/JikVsyKMh4zaRgBTKKD3Z4jG/B/JjnFbaZEOKI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ3Gk-00035z-A3;
	Mon, 15 Jun 2026 09:06:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ3Gi-00035n-VK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 09:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XZy5wMSiDgSztcVXwwgsTdupiVNDTJpjLK9MK/K3gSY=; b=IZ6rj8fPXvrqWDCEZ6ZAhLks2v
 5yC9i2C6RAYeYPhUl93aC4EZJ99D6JI4WZ4N73jodJDQkUX1Ll1C2kHFKUWaZMVIM9ATM7OWjWXY1
 os/s1Wo4NGe+gZiLXs4Jruv8vhiposDUUdku+RI/mKuNk3z5GNuxiFNR1DpERXIGbXOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XZy5wMSiDgSztcVXwwgsTdupiVNDTJpjLK9MK/K3gSY=; b=W
 2B54BBbA2cie1mvWQ1uQqnG98RaTsVFvKWAISkuSoEPcpJ2++oq/alet/wr+hHuQW7oIk7Yjzxhwb
 ORe+N6WHLIEW+nU6dcUQvCy90F3ijMV9aTv09/8/U2MRYvFhr9o5xX/QEbAx2fQ38YqJ954NsIWMt
 lgqIjqhvD6PdIyJ0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ3Gh-0000gU-LL for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 09:06:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC815406EB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 09:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD71F000E9;
 Mon, 15 Jun 2026 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781514362;
 bh=XZy5wMSiDgSztcVXwwgsTdupiVNDTJpjLK9MK/K3gSY=;
 h=From:To:Cc:Subject:Date;
 b=icBl4NEkjZYxoQaAesNy536AkUfliP4BEpdFucWqv7Ei/M/hkX5WYsI8fDvBnhgKp
 W4o1npOU0ACDrEETt8VF4tjB3qt3Ellmj8XnlNxYZmtdjULcf7NFgkiIkgw++uQi8s
 njEzZp5+9INUEkO0RtTB9y9gYNYGRjw4MH8ztUvKZPuEAJiQAdS1Iukgr878RCe5fX
 PgUtckRNxO+CUZcEXRWGQpoN/cQOW/5JUEmlJsCz5vG8mp/GQdUYA0ilySKngpBzWg
 IbaGfo+4JvJNP9EPXAbUVHII+WVyZLeKLYigRiOZzTc9qe22Ays6fvYCM06+95w6q5
 hQhqt8jHvzvNw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Mon, 15 Jun 2026 09:05:58 +0000
Message-ID: <20260615090558.1627456-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
MIME-Version: 1.0
X-Headers-End: 1wZ3Gh-0000gU-LL
Subject: [f2fs-dev] [PATCH] f2fs/009: use common _scratch_shutdown helper
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs has supported ioctl(_IOR ('X', 125, uint32_t)), so that
"f2fs_io shutdown" can be completely replaced w/ _scratch_shutdown(),
let's clean up in f2fs/009.

Suggested-by: Zorro Lang <zlang@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/009 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/f2fs/009 b/tests/f2fs/009
index fa4a39d16..39a4bad3d 100755
--- a/tests/f2fs/009
+++ b/tests/f2fs/009
@@ -12,6 +12,7 @@
 _begin_fstest auto quick
 
 _require_scratch
+_require_scratch_shutdown
 _require_inject_f2fs_command node i_links
 _require_command "$(type -P socket)" socket
 
@@ -106,7 +107,7 @@ ino=`stat -c '%i' $filename`
 $F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
 stat $filename >> $seqres.full
 rm $filename
-$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
+_scratch_shutdown -f
 sleep 6
 check_links 1 0 $ino
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
