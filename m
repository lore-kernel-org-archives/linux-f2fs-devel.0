Return-Path: <SRS0=4iVE=XW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F5DC4360C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:07:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A977217D7;
	Fri, 27 Sep 2019 10:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="FOTapOk2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="B+kQuJyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A977217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iDn9c-0006EX-6K; Fri, 27 Sep 2019 10:07:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iDn9b-0006EQ-Fg
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Sep 2019 10:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ZjPdW/IdyD2jHTWsZul9klMMCIxRuUEfgnYXinuAds=; b=FOTapOk238/lncQre5AtCaXhvZ
 8OR2YG88uLHRTUbM3ShbYcwlNjPNRia5w8pFvhgZVRza96Ps0VV43lQ1lK8XeaKSGYbZJyFfHGd7a
 +IVbEljXjSIkoipQmmSqWsTZ6Hhc9c1FOy29EbFa4QlDmQHySqtqYA9vJwIq9JepDx4Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/ZjPdW/IdyD2jHTWsZul9klMMCIxRuUEfgnYXinuAds=; b=B
 +kQuJyf6KgYwaw3ZXl1CGbroqpATsyt8pC/27LoanB5oKOIZQCbsocUvt0Vm5AscwF2c9RvooU/nE
 HPCQHxfWKnvZkSdloS2tOot33jCd64QSb3/3jgQGPr9QFANkpI5KThGn/+zYIgYAB0J3OGd1M1WuV
 Yn5INOGK7j1Gt5CU=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iDn9Z-008Duz-Qa
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Sep 2019 10:07:11 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 43289EE01DE7A3056AD2;
 Fri, 27 Sep 2019 18:07:02 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 27 Sep 2019 18:06:56 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <guaneryu@gmail.com>
Date: Fri, 27 Sep 2019 18:06:26 +0800
Message-ID: <20190927100627.9086-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1iDn9Z-008Duz-Qa
Subject: [f2fs-dev] [PATCH 1/2] common/defrag: support f2fs
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
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS supports defragment based on file granularity, adjust test suit
to support f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/config |  2 ++
 common/defrag | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index 4c86a492..c43be339 100644
--- a/common/config
+++ b/common/config
@@ -176,6 +176,7 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
+export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
@@ -240,6 +241,7 @@ case "$HOSTOS" in
 	export MKFS_BTRFS_PROG=$(set_mkfs_prog_path_with_opts btrfs)
 	export MKFS_F2FS_PROG=$(set_mkfs_prog_path_with_opts f2fs)
 	export DUMP_F2FS_PROG=$(type -P dump.f2fs)
+	export F2FS_IO_PROG=$(type -P f2fs_io)
 	export BTRFS_UTIL_PROG=$(type -P btrfs)
 	export BTRFS_SHOW_SUPER_PROG=$(type -P btrfs-show-super)
 	export BTRFS_CONVERT_PROG=$(type -P btrfs-convert)
diff --git a/common/defrag b/common/defrag
index 2bd739c0..9866d3da 100644
--- a/common/defrag
+++ b/common/defrag
@@ -27,6 +27,9 @@ _require_defrag()
 	rm -f $testfile $donorfile 2>&1 > /dev/null
 	DEFRAG_PROG="$E4DEFRAG_PROG"
 	;;
+    f2fs)
+	DEFRAG_PROG="$F2FS_IO_PROG defrag_file"
+	;;
     btrfs)
 	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
 	;;
@@ -140,7 +143,13 @@ _defrag()
 
 	[ ! -z $csum ] && CSUM_BEFORE=`md5sum $1`
 	STAT_BEFORE=`stat -c "a: %x m: %y c: %z" $1`
-	$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+
+	if [ $FSTYP == "f2fs" ]; then
+		_filesize=`ls -l $1 | $AWK_PROG '{print $5}'`
+		$DEFRAG_PROG 0 $_filesize $1 >> $seqres.full 2>&1
+	else
+		$DEFRAG_PROG -v $1 >> $seqres.full 2>&1
+	fi
 
 	_scratch_cycle_mount
 	STAT_AFTER=`stat -c "a: %x m: %y c: %z" $1`
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
