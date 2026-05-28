Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43691CD6E45
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 04:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySSeKtHIfjUiRqb2m+TUUL7LAGJ7Q1x2ML2lI7ghtig=; b=gmhupPx87IttTSBbBZ8zpRm/Tr
	F3KgeqRO5ONNq4IlKI0WwaDlrMmnOdUWSXWTe88XlvgJXYpZVkWhAtLd6Xt2PZFU2HsmjRZ6RKXFH
	jn9S/4ZC1Gljj5wbysmPeIojrfEjuyH/SM7H7uP28IcCMrS2mxwYim8ORmyWAHxzNh5M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSS15-00027I-JF;
	Thu, 28 May 2026 04:06:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wSS13-00026w-91
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y93qz9EZ2B+IYD7ga2KhpSAY8L3hm1RH+zshYysoJKw=; b=PweJNyZEzZXLVf4ONUMHy4hrZH
 KL4SQ00p9c/+AYWzIvRThixgInyimBcmhVVL9a4gpTqCjiqS7XxsCCnFxK4S+Oj9BDS0FoIySOrvu
 kkq0eprd+bvv2EMDLtIWFDHmuOX+IET1oFjGv9xAusKthUfvJ94yzA2tFFU2E4bKW9Os=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y93qz9EZ2B+IYD7ga2KhpSAY8L3hm1RH+zshYysoJKw=; b=QP/27xf/2ran7NLV05qpaTrTIh
 swKpLHtCxJPIBxelZwKMnHbxDovSQJ+JCrK8ivKL7tu06Lq/6SCRy2cWzfID+PpL4ypJerAqy36Ux
 l9Tp7uhb7SqkdaNTFDdZcQa7CM7TnPPcGAXuJpwVO2SHuEFzixp3WW85rH+icU2eaBzI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSS0y-00029U-RI for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD552605D4;
 Thu, 28 May 2026 04:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECFA1F00A3A;
 Thu, 28 May 2026 04:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779941186;
 bh=Y93qz9EZ2B+IYD7ga2KhpSAY8L3hm1RH+zshYysoJKw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f3wDIG89iJ2gMobfLifgntqY9aIktq+GOwH8mHNgyQNfyzV57JmMYkgKG6XRmysIg
 c5Ndszji/sccXvhlrUfVDyUo7snV3OQ1v6/v6hLC0s5pfxhUmRnPK77DzVe3h6TrSG
 iAjAamXXKTPLd9Ke6yWe9Sga2SXsC/hR8DaHtLx+q9NlVKXfX1IWshkQKP93RHI+88
 ICqFaWJjALaK2gz6xFxdq/maI+0+ssF1bydXIMekikHMPtY9iM0F+UK7PahIAYuQvI
 yoxuROvzmdSsjDKL9jey35IsqNqfquyCk61wIz6pU34NAOkuwIzhH6sIiaKSqoGKLc
 ZbhKdox8wTwlg==
To: fstests@vger.kernel.org
Date: Thu, 28 May 2026 12:05:38 +0800
Message-ID: <b4d359210f1233c416f70599e5df65a9e3c423ea.1779939330.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779939330.git.asj@kernel.org>
References: <cover.1779939330.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wSS0y-00029U-RI
Subject: [f2fs-dev] [PATCH v6 07/11] fstests: verify libblkid resolution of
 duplicate UUIDs
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: hch@infradead.org, zlang@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Verify how findmnt, df (libblkid) resolve device paths when multiple
block devices share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/803     | 84 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/803.out | 19 ++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 tests/generic/803
 create mode 100644 tests/generic/803.out

diff --git a/tests/generic/803 b/tests/generic/803
new file mode 100644
index 000000000000..b304a2743604
--- /dev/null
+++ b/tests/generic/803
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 803
+# Verify how libblkid resolve devices when multiple devices sharing the
+# same FSUUID.
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick mount clone
+
+_require_test
+_require_block_device $TEST_DEV
+_require_loop
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	umount $mnt1 $mnt2 2>/dev/null
+	_loop_image_destroy "${devs[@]}" 2> /dev/null
+}
+
+# Normalize pool devices and mount points names
+filter_pool()
+{
+	sed -e "s|${devs[0]}|DEV1|g" -e "s|${mnt1}|MNT1|g" \
+	    -e "s|${devs[1]}|DEV2|g" -e "s|${mnt2}|MNT2|g" | _filter_spaces
+}
+
+# Collect and print device tracking info from findmnt, /proc/mounts, and df.
+# This checks whether user-space tools get confused or remain accurate when
+# resolving a duplicate/cloned filesystem UUID.
+print_info()
+{
+	local mntpt=$1
+	local tgt=$(findmnt -no SOURCE $mntpt)
+	local fsuuid=$(blkid -s UUID -o value $tgt)
+
+	echo "mntpt=$mntpt tgt=$tgt fsuuid=$fsuuid" >> $seqres.full
+	echo
+	findmnt -o SOURCE,TARGET,UUID "$tgt" | tail -n +2 | \
+				sed -e "s/${fsuuid}/FSUUID/g" | filter_pool
+	awk -v dev="$tgt" '$1 == dev { print $1, $2 }' /proc/self/mounts | \
+								filter_pool
+	df --all --output=source,target "$tgt" | tail -n +2 | filter_pool
+}
+
+# Setup base loop device and its clone
+devs=()
+_loop_image_create_clone devs
+mkdir -p $TEST_DIR/$seq
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Mount both identical UUID filesystems simultaneously
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+print_info $mnt1
+print_info $mnt2
+
+# Cycle mounts and reverse the initialization order to see if libblkid / findmnt
+# resolution changes based on mount order.
+echo
+echo "**** mount cycle ****"
+_unmount $mnt1
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+
+print_info $mnt1
+print_info $mnt2
+
+status=0
+exit
diff --git a/tests/generic/803.out b/tests/generic/803.out
new file mode 100644
index 000000000000..20a1cb36a213
--- /dev/null
+++ b/tests/generic/803.out
@@ -0,0 +1,19 @@
+QA output created by 803
+
+DEV1 MNT1 FSUUID
+DEV1 MNT1
+DEV1 MNT1
+
+DEV2 MNT2 FSUUID
+DEV2 MNT2
+DEV2 MNT2
+
+**** mount cycle ****
+
+DEV1 MNT1 FSUUID
+DEV1 MNT1
+DEV1 MNT1
+
+DEV2 MNT2 FSUUID
+DEV2 MNT2
+DEV2 MNT2
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
