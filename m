Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD9CC3600B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:59:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tx3sB-0004gM-Ey;
	Tue, 25 Mar 2025 12:59:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tx3s7-0004fq-9I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 12:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjdF9hYdVVwngjXbe4+CWCYmZrvO/e1agpEymOCh0iE=; b=Ed8sUzDQkxFr/fSCogtwrEQlpV
 5emTsGhAYD0tmKs0U5bwx1qheumAXVWL5KZKdAA7bNG6C57WPEvoEspQqrvQnGczXVeTlJzOuNJQC
 pRjp0lTsf9+r9HpgT2iVmWMJyFNT3lRBWl7x+TA6G6diwj6dFbTeaJAu0JgNFw33Kh+s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kjdF9hYdVVwngjXbe4+CWCYmZrvO/e1agpEymOCh0iE=; b=ZSFtMLEYEnqbsrXaa+wfnBvYqP
 R/FLC+2TOO0FAcaoa+d2T7ToNCULgEttff+nYQuIdWJ2KwBGRjGyRshg4+B0vJRCDyA3PVBRdn1mO
 l+NlSctjppAuPooZi6dNNWbOqLf/RzS/3uujGFd/xWQXkcU2DvK40eKSlqT1CRAkroKo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tx3rw-0004An-Sv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 12:59:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F368E61596
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Mar 2025 12:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A5CC4CEED;
 Tue, 25 Mar 2025 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742907529;
 bh=00DLigW1BznJ8vTs4yfqAv7qlo9NXstRvHEGDfH0+AU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rvqD+t/vGpY2tdZeuLreLdmIwRKIAfejszt4vOWSfuHf9r+gK5W4XmEVMBNmJ9yHW
 fySK7S+6yLZcttkhceiJXdl4tm1ABkR5ZcDtvkBKlBOigBrHTgrByFuIjpoo4fvl/Z
 5cVcQmIe9lGSBafSEh1ZEKmbhCZbX5z1WEFuZEhgFT+BwnhaliQ/0PeiUEgbjrhfom
 i5pdV2QJ8WTkJTGT2JkgZaG7dRYS8qFYjgahQg1w6d7AMQHUH6rKxFx5fTxm3AqBfv
 j67053xcsZ9lM1jwpZKnbrHETcKefgik2rH6Zu+SfeFYphquIlFD3IKEPsiw/T6+tX
 gvxXbYNqq/sIw==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Tue, 25 Mar 2025 20:58:23 +0800
Message-ID: <20250325125824.3367060-5-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1tx3rw-0004An-Sv
Subject: [f2fs-dev] [PATCH v5 5/6] common/rc: introduce
 _check_f2fs_filesystem()
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

_check_generic_filesystem() will fail the test once it detects
corruption, let's introduce _check_f2fs_filesystem() to just check
filesystem w/ --dry-run option, and return the error number, then
let caller to decide whether the corruption is as expected or not.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/rc | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/common/rc b/common/rc
index ac2bac81..cabd44de 100644
--- a/common/rc
+++ b/common/rc
@@ -3527,6 +3527,50 @@ _check_generic_filesystem()
     return 0
 }
 
+_check_f2fs_filesystem()
+{
+    local device=$1
+
+    # If type is set, we're mounted
+    local type=`_fs_type $device`
+    local ok=1
+
+    if [ "$type" = "f2fs" ]
+    then
+        # mounted ...
+        local mountpoint=`_umount_or_remount_ro $device`
+    fi
+
+    $F2FS_FSCK_PROG --dry-run $device >$tmp.fsck.f2fs 2>&1
+    if [ $? -ne 0 ];then
+        _log_err "_check_f2fs_filesystem: filesystem on $device is inconsistent"
+        echo "*** fsck.f2fs output ***" >>$seqres.full
+        cat $tmp.fsck.f2fs              >>$seqres.full
+        echo "*** end fsck.f2fs output" >>$seqres.full
+
+    ok=0
+    fi
+    rm -f $tmp.fsck.f2fs
+
+    if [ $ok -eq 0 ]
+    then
+        echo "*** mount output ***"		>>$seqres.full
+        _mount					>>$seqres.full
+        echo "*** end mount output"		>>$seqres.full
+    elif [ "$type" = "f2fs" ]
+    then
+	# was mounted ...
+	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
+	ok=$?
+    fi
+
+    if [ $ok -eq 0 ]; then
+	return 1
+    fi
+
+    return 0
+}
+
 # Filter the knowen errors the UDF Verifier reports.
 _udf_test_known_error_filter()
 {
@@ -3631,6 +3675,9 @@ _check_test_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        _check_f2fs_filesystem $TEST_DEV
+        ;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -3687,6 +3734,9 @@ _check_scratch_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        _check_f2fs_filesystem $device
+        ;;
     *)
 	_check_generic_filesystem $device
 	;;
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
