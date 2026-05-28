Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D786CD6E45
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 04:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vyW/SSCL+0OQF7KzEHtFPHh02cOZwIpdDm5XRk5nTfg=; b=Zgo4+vSnqyBjCaPyeOePSiTqky
	8OrkjbcKg29qumpCU3VreqIdeVPXVgbnrUUa74W/HTPtrYIAIu97Des+J4crOQng+aPaKYAxZ5E71
	gOn+saCTbOBYdOVXHFu9cZpKNaT/EiD18To9BC9qdMnqJDVT31s8CNNde20VfLnIw81w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSS0o-0003SB-7x;
	Thu, 28 May 2026 04:06:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wSS0m-0003S4-GR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=81pf5d6d5QrOm2o8qa6SqtrOWC9C6qeuxU6yd+94e28=; b=M6EM3FkLyEQOTj1kbkdmjMuHvp
 B2BOj1LjzQeVlwfDbS97eHbV52B6QTJkyk2k3/EwxRQfKmtGmO0ZecR1sAxtW2DC+7nQ3AjVJ9vCO
 cEGxdu3UmZa42KxuftdRhEq8zZt3PUrmSnSnvBqoxscVeKaII0vOIdYvWXXepbflOfmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=81pf5d6d5QrOm2o8qa6SqtrOWC9C6qeuxU6yd+94e28=; b=bTCCjsLXFjh1p5Z+MOXdRJR/i4
 te2dtDeeK+Y6vyrPvw7EvGI3tKdFbviqIHcCeF98mKB13Yy5Zb6F06OoWiotRiwP5bVv7xDgOTSTS
 OXcV7I/8j9dTN694/EU3J4NaTYmfhyil0ZtkWmLb+3Ej/As+tqsA3Ga+rbTK9JIpR71w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSS0l-00023i-GP for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 04:06:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 444B0605D4;
 Thu, 28 May 2026 04:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388AA1F00A3A;
 Thu, 28 May 2026 04:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779941173;
 bh=81pf5d6d5QrOm2o8qa6SqtrOWC9C6qeuxU6yd+94e28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IABPO77o+8CFbBvKnTi/NY8j9oUYUabcUKrTg4KUCg8FJZ+1y/5L6OADuECanFWbI
 /ucyHO+sYcw3MiL/MMseUTiWA76WBCsgOXu9/jTtgmK+5uB1jBzKKTcKsxfULa2T0c
 P1Co6+StrGUoW7mI7dEt7kcR3IMbBINBPSnMTvH9l8m0opp2ud91K/gvDVjtcY573w
 PBuVEGunSc7E6Gcg6+DveA5OXQkGWWeAv5Y4pW7YddxG1LXj/rcB2tRq5C+52H2nmx
 VAlKHRy0glt+ZGFZtypfX7Bly/A1FreOKkfW12tuMC4H5EhIPDyiKbZCRT0IMTbX6u
 7N0J+hSLsN+Zg==
To: fstests@vger.kernel.org
Date: Thu, 28 May 2026 12:05:32 +0800
Message-ID: <421c7cdd5aae27b99d04dddf08c5d9df79c2f790.1779939330.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779939330.git.asj@kernel.org>
References: <cover.1779939330.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wSS0l-00023i-GP
Subject: [f2fs-dev] [PATCH v6 01/11] fstests: add _loop_image_create_clone()
 helper
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

Introduce _loop_image_create_clone() and _loop_image_destroy() to mkfs an
image file and clone it to another image file, and attach a loop device to
them. And its destroy part.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/common/rc b/common/rc
index 79189e7e6e94..d7e3e0bdfb1e 100644
--- a/common/rc
+++ b/common/rc
@@ -1520,6 +1520,69 @@ _scratch_resvblks()
 	esac
 }
 
+# Create a small loop image, run an optional tuning function ($2) on it,
+# clone it, and attach both to loop devices, returned in ($1).
+# Args:
+#   $1: Nameref to return the array of allocated loop devices [base, clone].
+#   $2: Optional callback function to tune the base filesystem before cloning.
+_loop_image_create_clone()
+{
+	local -n _ret=$1
+	local pre_clone_tune_func="$2"
+	local img_file=$TEST_DIR/${seq}.img
+	local img_file_clone=$TEST_DIR/${seq}_clone.img
+	local size=$(_small_fs_size_mb 128) # Smallest possible
+	local loop_devs
+
+	# Since we copy the block device image, we keep its size small.
+	_require_fs_space $TEST_DIR $((size * 1024))
+
+	_create_file_sized $((size * 1024 * 1024)) $img_file ||
+				_fail "Failed: Create $img_file $size"
+
+	loop_devs=$(_create_loop_device $img_file)
+	_ret=($loop_devs)
+
+	case $FSTYP in
+	xfs)
+		_mkfs_dev "-s size=4096" ${loop_devs[0]}
+		;;
+	btrfs)
+		_mkfs_dev ${loop_devs[0]}
+		;;
+	*)
+		_mkfs_dev ${loop_devs[0]}
+		;;
+	esac
+
+	# Only execute if the function argument is not empty
+	if [ -n "$pre_clone_tune_func" ]; then
+		$pre_clone_tune_func ${loop_devs[0]}
+	fi
+
+	sync ${loop_devs[0]}
+	cp $img_file $img_file_clone
+
+	loop_devs="$loop_devs $(_create_loop_device $img_file_clone)"
+
+	_ret=($loop_devs)
+}
+
+# Teardown loop devices and delete their underlying backing image files.
+# Accepts a list of loop device paths (e.g., /dev/loop0 /dev/loop1).
+_loop_image_destroy()
+{
+	for d in "$@"; do
+		# Retrieve the path of the backing file
+		local f=$(losetup --noheadings --output BACK-FILE $d)
+
+		# Detach the loop device from the backing file
+		_destroy_loop_device "$d"
+
+		# Clean up the backing disk image file
+		[ -n "$f" ] && rm -f "$f"
+	done
+}
 
 # Repair scratch filesystem.  Returns 0 if the FS is good to go (either no
 # errors found or errors were fixed) and nonzero otherwise; also spits out
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
