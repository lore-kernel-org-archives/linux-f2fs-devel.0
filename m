Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2BC531F9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gf6E4jTKMypz+udP0k8E8d7+//HtMhyKoQQogr5CKMw=; b=T2JvSiKovTcyWVdi9+CRc0ppCt
	/q1Lp/W+izJ+Mz+LHgw4RIqh0heus+GHLU1zQSRfSbFuFwqjM+tiBZkrNyntfusBPBj3WMDYZXbN7
	rtjJuCrI9nFLPfXIzp3mrPdIcHrUBRjdPmB5jCMgkU3tH7N2ylDdiWnqxflCACbNLw3o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnWzG-00033W-EO;
	Sat, 25 Jul 2026 07:39:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wnWys-00032d-23
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DV7Jn2uM7I5dhJYWcrR98O8AGHL2werlvw5uBfEBhZ4=; b=NqT4MXhmMATh0Ll59VTesstSnu
 Ie/z8ixk5fI57TEYW5FKFPeve0OKhO7ESTeWkX2056NLhRlyhvYOtOVdxyPCoU3IHRmBdQcN4o8fm
 Z12jFyROM5fk/WE7lKHqSXaSKDrwE8pgoQcRHIyrRMHxWAWVzmv+RjfGYbkw9s8BPxEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DV7Jn2uM7I5dhJYWcrR98O8AGHL2werlvw5uBfEBhZ4=; b=nHc89e00c/zIGj/FZgLOulcjih
 raqFyK6paaPMg2sEEcKUj/9bwvz2KTneIQn6P2zQwy2DpDKl7GoJVZ0GCnirA5pNSenzLU8W3hXXD
 1DPgVcJPQ7FtKZ/QlR5sJSYCrvwo/ONNGibD/GJ8meiHNJPPisQMdA0KVtv7zgtCHoDM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnWyv-0002Ff-Tf for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 07:39:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8087407D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 07:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744441F00A3A;
 Sat, 25 Jul 2026 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784965168;
 bh=DV7Jn2uM7I5dhJYWcrR98O8AGHL2werlvw5uBfEBhZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oggScPL1xubsVyIN8+2G7t3coZ7bAdyLP+KbDVb0M8TY4eJKuV5GDOtT3UtXRGiNz
 lZoxowlzCqfbbzdgFEhC1iUeeZpQxOPrKPXeAjbpAkS5PLos7K2biXi68dTWvx+Her
 jK93TW4HOx+t9wYjw0gcFv25CPQ6R0KbDxofNQ60SsjeF1bB+eUH+Cwfinc5v9YhQ9
 Yz6xbmAZqQxheqTUIwQyeqgcvPQ07zFgTF+VDlbHUZd+OIRzqKBQUlZQaX1nKbipBh
 Qe7hQyrhN6VLwWJou/rdpjVFMQsZ8hFaJ/ZgvqhP07WME95fL9kTxoNy/HqKIZ6TzY
 BhAxeLtKpuLdw==
To: fstests@vger.kernel.org
Date: Sat, 25 Jul 2026 15:38:58 +0800
Message-ID: <4fa4f6bc500e0496e3d8598d38cf69597493a25b.1784949154.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784949154.git.asj@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wnWyv-0002Ff-Tf
Subject: [f2fs-dev] [PATCH v8 01/13] fstests: add _loop_image_create_clone()
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
Cc: zlang@kernel.org, djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
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
 common/rc | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/common/rc b/common/rc
index 106f044adc2d..e8ff5be0c547 100644
--- a/common/rc
+++ b/common/rc
@@ -1520,6 +1520,71 @@ _scratch_resvblks()
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
+	local loop_devs=()
+
+	# Since we copy the block device image, we keep its size small.
+	_require_fs_space $TEST_DIR $((size * 1024 * 2))
+
+	_create_file_sized $((size * 1024 * 1024)) $img_file ||
+				_fail "Failed: Create $img_file $size"
+
+	loop_devs=("$(_create_loop_device $img_file)")
+
+	case $FSTYP in
+	xfs)
+		_mkfs_dev -s size=4096 "${loop_devs[0]}"
+		;;
+	btrfs)
+		_mkfs_dev "${loop_devs[0]}"
+		;;
+	*)
+		_mkfs_dev "${loop_devs[0]}"
+		;;
+	esac
+
+	# Only execute if the function argument is not empty
+	if [ -n "$pre_clone_tune_func" ]; then
+		$pre_clone_tune_func "${loop_devs[0]}"
+	fi
+
+	sync "${loop_devs[0]}"
+	cp $img_file $img_file_clone || _fail "Failed to copy cloned image"
+
+	loop_devs+=("$(_create_loop_device $img_file_clone)")
+
+	_ret=()
+	for i in "${loop_devs[@]}"; do
+		_ret+=("$i")
+	done
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
