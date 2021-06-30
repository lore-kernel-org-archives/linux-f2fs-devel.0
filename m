Return-Path: <SRS0=Ke7g=LY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC5C11F69
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Jun 2021 11:32:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9C3613F1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Jun 2021 11:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9C3613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lyYRq-0001nL-8N; Wed, 30 Jun 2021 11:32:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sunke32@huawei.com>) id 1lyYRn-0001n5-W4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Jun 2021 11:32:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QvM5a4H6Onzj7JlDbtPucwJdbCHQ5SB8QvE0JjooTk8=; b=Nw6CIm7oTfySKsKbRDdMu+fu9/
 8SVc9UN3IYLNdfwjiAR80AfMDw0qacuLf+vp69lEn+8O1ZBXd/xw+xasmy4hCBhCm748aWu+l+c5M
 A8xy3ZyfFwlETcC/PoHq8XOOUxYOjZyUJBD+razx4nDPgMJn2dx6mZ2pFXVLv4IMDt4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QvM5a4H6Onzj7JlDbtPucwJdbCHQ5SB8QvE0JjooTk8=; b=X8rtd5D20ivmlNbxkha0tLIJmc
 Ld1z+X3Vfoepi3BCKx/JhVmhQ9tEGdocV0HXhm0DT4o0H8DawX4bJjXzLXTrsNtWWano6sSFet5k1
 2jMcj/55nX5ibIRKsuAvIf3wtvH6QvZHckz2flhqRW2zQ047zqpnyD988Fgn2nvjk7wg=;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lyYRg-004dVb-HS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 Jun 2021 11:32:03 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GFJy32dDlzZpCM;
 Wed, 30 Jun 2021 19:28:43 +0800 (CST)
Received: from dggema759-chm.china.huawei.com (10.1.198.201) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 19:31:48 +0800
Received: from huawei.com (10.175.101.6) by dggema759-chm.china.huawei.com
 (10.1.198.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 19:31:47 +0800
From: Sun Ke <sunke32@huawei.com>
To: <fstests@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 <guan@eryu.me>, <chao@kernel.org>
Date: Wed, 30 Jun 2021 19:37:36 +0800
Message-ID: <20210630113736.551843-4-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210630113736.551843-1-sunke32@huawei.com>
References: <20210630113736.551843-1-sunke32@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema759-chm.china.huawei.com (10.1.198.201)
X-CFilter-Loop: Reflected
X-Headers-End: 1lyYRg-004dVb-HS
Subject: [f2fs-dev] [PATCH v3 3/3] generic/260: f2fs is also special
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
Cc: sunke32@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It fail on f2fs:

 [+] Default length with start set (should succeed)
 [+] Length beyond the end of fs (should succeed)
 [+] Length beyond the end of fs with start set (should succeed)
+After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
+It seems that fs logic handling len argument overflows

The root cause is f2fs can tag a special flag TRIMMED_FLAG to indicate
the whole filesystem is trimmed, so after mkfs/fstrim(), following
fstrim() won't trim any block.

Suggested-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/generic/260 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/generic/260 b/tests/generic/260
index 8d6d6c79a5c1..b15b4e570bd1 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -95,7 +95,10 @@ fi
 # It is because btrfs does not have not-yet-used parts of the device
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+# F2fs is also special. F2fs can tag a special flag TRIMMED_FLAG to
+# indicate the whole filesystem is trimmed, so after mkfs/fstrim(),
+# following fstrim() won't trim any block.
+if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
 	status=1
 	echo "After the full fs discard $bytes bytes were discarded"\
 	     "however the file system is $(_math "$fssize*1024") bytes long."
@@ -154,8 +157,11 @@ _scratch_mount
 # It is because btrfs does not have not-yet-used parts of the device
 # mapped and since we got here right after the mkfs, there is not
 # enough free extents in the root tree.
+# F2fs is also special. F2fs can tag a special flag TRIMMED_FLAG to
+# indicate the whole filesystem is trimmed, so after mkfs/fstrim(),
+# following fstrim() won't trim any block.
 bytes=$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
-if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ]; then
+if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP != "btrfs" ] && [ $FSTYP != "f2fs" ]; then
 	status=1
 	echo "It seems that fs logic handling len argument overflows"
 fi
-- 
2.25.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
