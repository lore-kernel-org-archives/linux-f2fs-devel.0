Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A69CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xa1g4F3dBspgb9cDf/sANumoMhjoPZDrY5UB7gwD0Jc=; b=Gw/r28eh3HQM81NxG7oXZLDDBM
	5BrEgu0gguu6imvZnu05hDrB54H0NU600MVpVqBbYL5ryzBmZpjxMWhl5Lm7GfRr6JKRu3BNJO2YU
	TXnzu2XaW5h9kYZK76g6tZ1t2ZyDVxxPgUDG2VaxdXhvWHIqwuzmR1Rs2TY+BLpMS5HA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yK-0006kM-6r;
	Tue, 06 Oct 2026 08:56:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yI-0006kG-Dn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CmbVMI7lUvfkO3SWgb3kTNHaNpNWSR/IBSLglzGhdUU=; b=mhp4e65Ajvlohpwbv7kxjXD9/v
 GaILnqgDp1dq88/7heFbWMYjshFxtT/+Tb5kVXw3PvDnZ6+khaE0fuKbUkjb3XMxLN8VcKogEukpV
 aCg4zvkROwida8FXqlBhAyv4XU1X4w1GxKx8i4Rg89ZQSjxqLZGjto76TuRNdMdduBcc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CmbVMI7lUvfkO3SWgb3kTNHaNpNWSR/IBSLglzGhdUU=; b=aOHuO2r/vPxJ5zfB2cW3B8WvaJ
 XiysaJCJu5UkS8Z7ktPZlKOz0ZEd0oDazUiuB+kNKx6IEtHI4zW/aOa6NwrOGvrlDkQLj1jBfRJK+
 I5IwHAEmbls6HFDZ4x91qbtRnUCJj7NLSSmmBZ98rMHGC/FwsBxeKLMbu4JexTCo4c+Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yF-0000L5-Ez for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2699B43D96
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4B61F00898;
 Tue,  6 Oct 2026 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276978;
 bh=CmbVMI7lUvfkO3SWgb3kTNHaNpNWSR/IBSLglzGhdUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aDPPkKYg+C5Z298ieT/s7vXoeq4QvnbG4MW4RSyrfbTeLiNilJdOyDJOonKZEE9bW
 B3Zv50r1hGkwHWRGAOtHyHPoZzIrxBb93GY8i5jjsumdmY8RyJekt2vubJG37z3A82
 OnIqvEhwagNMXDmz5OjeceUYtzHRPIaOUj2JhiWuNcEAeeP7GfM4I6x8fOKriFrsch
 0VYz5oyx8MZyjZoRKqumUrKiTYIeQledlxA9/r751g3M8m/apiGzsra0Ae4ADmegU9
 YsfHCXPELw7LXPPWGmXMtS7bY0SxKsqz14AMUWerpwK3N402E1AD8Z847zN/lvl+iQ
 qX+AEO8f4g+ww==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:28 +0800
Message-ID: <d97b87a346488157df940edbf89c62b71bbd0340.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yF-0000L5-Ez
Subject: [f2fs-dev] [PATCH 02/21] fstests: introduce
 _create_cloned_loop_devs() helper
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Introduce _create_cloned_loop_devs() and _destroy_cloned_loop_devs to mkfs an
image file and clone it to another image file, and attach a loop device to
them. And its destroy part.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/common/rc b/common/rc
index 7868e6d311a2..f2ab4bc491af 100644
--- a/common/rc
+++ b/common/rc
@@ -1534,6 +1534,72 @@ _scratch_resvblks()
 	esac
 }
 
+# Create a small loop image, run an optional tuning function ($2) on it,
+# clone it, and attach both to loop devices, returned in ($1).
+# Args:
+#   $1: Nameref to return the array of allocated loop devices [base, clone].
+#   $2: Optional callback function to tune the base filesystem before cloning.
+_create_cloned_loop_devs()
+{
+	local -n _ret=$1
+	local pre_clone_tune_func="$2"
+	local img_file="$TEST_DIR/${seq}/orig.img"
+	local img_file_clone="$TEST_DIR/${seq}/clone.img"
+	local size=$(_small_fs_size_mb 128) # Smallest possible
+	local temp_dev
+	local loop_devs=()
+
+	# All current callers mount the original and the clone simultaneously.
+	_require_clone_mount
+
+	# Since we copy the block device image, we keep its size small.
+	_require_fs_space $TEST_DIR $((size * 1024 * 2))
+
+	_create_file_sized $((size * 1024 * 1024)) $img_file ||
+				_fail "Failed: Create $img_file $size"
+
+	temp_dev=("$(_create_loop_device_like_bdev $img_file ${TEST_DEV})")
+	_mkfs_dev "${temp_dev}"
+
+	# Only execute if the function argument is not empty
+	if [ -n "$pre_clone_tune_func" ]; then
+		$pre_clone_tune_func "${temp_dev}"
+	fi
+
+	# We are about to copy the loop device's backing file
+	# Flush loop device's buffer cache
+	blockdev --flushbufs "${temp_dev}"
+	# Sync system's dirty pages including backing file's
+	sync
+	_destroy_loop_device "${temp_dev}"
+
+	cp $img_file $img_file_clone || _fail "Failed to copy cloned image"
+
+	loop_devs=("$(_create_loop_device_like_bdev $img_file ${TEST_DEV})")
+	loop_devs+=("$(_create_loop_device_like_bdev $img_file_clone ${TEST_DEV})")
+
+	# Help debug
+	losetup --list "${loop_devs[0]}" >> $seqres.full
+	losetup --list "${loop_devs[1]}" >> $seqres.full
+
+	_ret=("${loop_devs[@]}")
+}
+
+# Teardown loop devices and delete their underlying backing image files.
+# Accepts a list of loop device paths (e.g., /dev/loop0 /dev/loop1).
+_destroy_cloned_loop_devs()
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
