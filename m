Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67073CA6002
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDzEGx67YeFH+fh/9O0CP/wDlZpsvvXzzRX8dm6/pQ4=; b=XTbe5WFdMjsbTA7rzagKvi+NxT
	qzyJL7ouLphch2YfuI7xfYMHanfB7mXOTJOj++b7LEEi/5x0O2B6xJkhjvcohw3WpuT20xxE8mNqR
	sSDl5nyazEA8i09cczvckQno4FVCBqRlu7lM8RhO65bpjjPbe6KSzQoNdZvv4WWRGl6k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yW-00029S-A2;
	Tue, 06 Oct 2026 08:56:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yV-00029J-8t
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Y9Rspeo04EJqvw+V0/Waciw0DhWmA3cTc51A0KgWUo=; b=S/dTAwjEPnffegjYHygLWDaSZs
 54hsrNMLp0OlVhg7vSW9PoeIOS2Cp0xsVN06EgMmuCM5MU8g/KxxUIf6eNjZG713N+Aiv51YdNNjF
 sqi5aLJjclGxnwWQuL7X+zuUcgm2UPMjn/8hBSTrwkK8WiWOK/LeKp1+lHseKXTAjht8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1Y9Rspeo04EJqvw+V0/Waciw0DhWmA3cTc51A0KgWUo=; b=MgXJoTwNQLUBahkPUMVYjEVEol
 2eaPbfMtdciUj4JgETbtgKft+7JAc3z8MWoGI218CICSe57XwiZxDokV/24s5pZaYtED+KiAH2XQh
 fYgA6EFTl+TQcX7ZGLYjMSVpmO+ReXQ23nkcsVAjuAZsVUgnBpeD5JZayZO9/jOBfjm4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yS-000254-5U for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 916FF601F6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5521F000FF;
 Tue,  6 Oct 2026 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276990;
 bh=1Y9Rspeo04EJqvw+V0/Waciw0DhWmA3cTc51A0KgWUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nkH6fwpJRQOQATBlTMfu9IIHHwiTtcJm6HG23AXPkSNpjzuifYzFs+CMxBtMsS9ca
 LtQr/sDmzG4PRxPyGnBtoS/2v7//IGRdKxG83hNIP0hmYvCFmlvmHWosRG1my5HMXi
 olNJx/smX4+14uXJ8ZNegGpUMvTaNN9woljs5Rvtr/dPTdyfD+7YwYeA2RSa765+ra
 TCap4tafwgdXRJ1vUIGycvqTISgk2XXCxeXW13/PNuO7/86vF+aSUrj/3181qAbEpC
 A5SLlkJKLetJ5Ib6zJBlaO8awQa7JG5NFwR+3cZuG6Y49uhxG6y+/2RXV628/bxxv5
 2quny9EMe9ZrQ==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:34 +0800
Message-ID: <4a9b0540afb1af06b37a47b9171a0ca2b840da17.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yS-000254-5U
Subject: [f2fs-dev] [PATCH 08/21] fstests: verify fanotify isolation on
 cloned filesystems
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

Verify that fanotify events are correctly routed to the appropriate
watcher when cloned filesystems are mounted.
Helps verify kernel's event notification distinguishes between devices
sharing the same FSID/UUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/901     | 142 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/901.out |   7 +++
 2 files changed, 149 insertions(+)
 create mode 100644 tests/generic/901
 create mode 100644 tests/generic/901.out

diff --git a/tests/generic/901 b/tests/generic/901
new file mode 100644
index 000000000000..55be6c10cf46
--- /dev/null
+++ b/tests/generic/901
@@ -0,0 +1,142 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 901
+# Verify fanotify FID functionality on cloned filesystems by setting up
+# watchers and making sure notifications are in the correct logs files.
+
+. ./common/preamble
+
+_begin_fstest auto quick mount tempfsid
+
+_require_test
+_require_loop
+_require_command "$SEMANAGE_PROG" semanage
+_require_command "$FSNOTIFYWAIT_PROG" fsnotifywait
+_require_fanotify_function
+_require_unique_f_fsid
+
+_cleanup()
+{
+	cd /
+	[[ -n $pid1 ]] && { kill -TERM "$pid1" 2> /dev/null; wait $pid1; }
+	[[ -n $pid2 ]] && { kill -TERM "$pid2" 2> /dev/null; wait $pid2; }
+
+	if [ "$semanage_added" = "yes" ]; then
+		semanage permissive -d unconfined_t >/dev/null 2>&1 || true
+	fi
+
+	umount $mnt1 $mnt2 >/dev/null 2>&1
+	_destroy_cloned_loop_devs "${devs[@]}" 2> /dev/null
+	rm -r -f $tmp.*
+}
+
+# Run fsnotifywait in unbuffered mode to watch filesystem-wide create events
+monitor_fanotify()
+{
+	local mmnt=$1
+	exec stdbuf -oL $FSNOTIFYWAIT_PROG -m -F -S -e create "$mmnt" 2>&1
+}
+
+# Transform f_fsid into the hi.lo format used in fanotify FID logs
+fsid_to_fid_parts()
+{
+	local fsid=$1
+	# Pad to 16 hex chars (64-bit), then split into two 32-bit halves
+	local padded=$(printf '%016x' "0x${fsid}")
+	local hi=$(printf '%x' "0x${padded:0:8}")   # strips leading zeros
+	local lo=$(printf '%x' "0x${padded:8:8}")   # strips leading zeros
+	echo "${hi}.${lo}"
+}
+
+rm -rf $TEST_DIR/$seq 2>/dev/null
+mkdir -p $TEST_DIR/$seq
+# Create base loop device and its clone
+devs=()
+_create_cloned_loop_devs devs
+mnt1=$TEST_DIR/$seq/mnt1
+mnt2=$TEST_DIR/$seq/mnt2
+mkdir -p $mnt1
+mkdir -p $mnt2
+
+# Mount both base and clone filesystems using required clone mount options
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[0]} $mnt1 || \
+						_fail "Failed to mount dev1"
+_mount $(_common_dev_mount_options) $(_clone_mount_options) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+# Fetch filesystem IDs to verify the kernel can differentiate between them
+fsid1=$(stat -f -c "%i" $mnt1)
+fsid2=$(stat -f -c "%i" $mnt2)
+
+log1=$tmp.fanotify1
+log2=$tmp.fanotify2
+
+pid1=""
+pid2=""
+echo "Setup FID fanotify watchers on both mnt1 and mnt2"
+
+# Permit unconfined_t domains when SELinux is enforcing to prevent fanotify
+# blockages
+semanage_added="no"
+if [ "$(getenforce 2>/dev/null)" = "Enforcing" ]; then
+    if ! semanage permissive -l | grep -q "unconfined_t"; then
+        semanage permissive -a unconfined_t >/dev/null 2>&1 && semanage_added="yes"
+    fi
+fi
+
+# Start asynchronous fanotify monitors
+( monitor_fanotify "$mnt1" > "$log1" ) &
+pid1=$!
+( monitor_fanotify "$mnt2" > "$log2" ) &
+pid2=$!
+sleep 2
+
+if ! kill -0 "$pid1" 2>/dev/null || ! kill -0 "$pid2" 2>/dev/null; then
+	cat "$log1"
+	cat "$log2"
+	_fail "$FSNOTIFYWAIT_PROG setup failed"
+fi
+
+echo "Trigger file creation on mnt1"
+touch $mnt1/file_on_mnt1
+sync
+sleep 1
+
+echo "Trigger file creation on mnt2"
+touch $mnt2/file_on_mnt2
+sync
+sleep 1
+
+echo "Verify fsid in the fanotify"
+kill $pid1 $pid2
+wait $pid1 $pid2 2>/dev/null
+pid1=""
+pid2=""
+
+e_fsid1=$(fsid_to_fid_parts "$fsid1")
+e_fsid2=$(fsid_to_fid_parts "$fsid2")
+
+# Dump debug details to the full log
+echo $fsid1 $e_fsid1 $fsid2 $e_fsid2 >> $seqres.full
+cat $log1 >> $seqres.full
+cat $log2 >> $seqres.full
+
+# Ensure monitor 1 only captured events belonging to mnt 1 and fsid 1
+if grep -qF "$e_fsid1" "$log1" && ! grep -qF "$e_fsid2" "$log1"; then
+	echo "SUCCESS: mnt1 events found"
+else
+	[ ! -s "$log1" ] && echo "  - mnt1 received no events."
+	grep -qF "$e_fsid2" "$log1" && echo "  - mnt1 received event from mnt2."
+fi
+
+# Ensure monitor 2 only captured events belonging to mnt 2 and fsid 2
+if grep -qF "$e_fsid2" "$log2" && ! grep -qF "$e_fsid1" "$log2"; then
+	echo "SUCCESS: mnt2 events found"
+else
+	[ ! -s "$log2" ] && echo "  - mnt2 received no events."
+	grep -qF "$e_fsid1" "$log2" && echo "  - mnt2 received event from mnt1."
+fi
+
+_exit 0
diff --git a/tests/generic/901.out b/tests/generic/901.out
new file mode 100644
index 000000000000..414e12d10b27
--- /dev/null
+++ b/tests/generic/901.out
@@ -0,0 +1,7 @@
+QA output created by 901
+Setup FID fanotify watchers on both mnt1 and mnt2
+Trigger file creation on mnt1
+Trigger file creation on mnt2
+Verify fsid in the fanotify
+SUCCESS: mnt1 events found
+SUCCESS: mnt2 events found
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
