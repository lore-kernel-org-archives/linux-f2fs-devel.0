Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52814C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MWwYAlhizty0Mxb8lvw7WYUKoczHbchv9crruNBuVUk=; b=l8XBR4o7gdtdLFYij38UH+7IHP
	hvSpXXLo/Ac2PjHTN3KssVjlRMokHkGTspSdeP53CKBcYOCN9zPmZwQIb3M6QSv/koYIWYm1/JxKu
	fg4Vvz/omEfF6Djmyim5sVQWNrORBd06WYusMS2tS/Mz2JdkwSRLdl5NJbBZO86pZj6E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHzt-0002lW-TP;
	Fri, 24 Jul 2026 15:39:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnHzt-0002j1-74
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:39:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZVwAI1hSkCaUpLf6ewphBAqD/y8icd57r1c7QrNLrio=; b=Vt8k1Zaz11LJU6djKyxhr1y/76
 yZZOh81X9bEbvvwkpDIV0jIB5JmKji599Y9C1Fn6dwFcqMXVjaZtGTUrLZs4Zm9Yl74yjpdReZls9
 HFRpCIu8Rmr6OKSL0AAXRe+kVsNtuQXq00NlA86x4JBEJM81mUhKYxSMQyOWCjgescf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZVwAI1hSkCaUpLf6ewphBAqD/y8icd57r1c7QrNLrio=; b=Xs4DLHM3YTYWy54GQPeIv2mURe
 de6kCuxWWpe5ayMiZQ1AI3/oCZ1S+WFKuYbwTxN7i2uBlWZkl/OWg09SJpWOyG1Fcl/fYiUMhSeUG
 4IYHevW5aLUcTceD8Y/03QOmzZ8RdqtdJVeoTJwPnzXdm+HJUeTf0KAZjwPL7FNKe+qQ=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHzp-0007tX-7x for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:39:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E69957B854;
 Fri, 24 Jul 2026 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVwAI1hSkCaUpLf6ewphBAqD/y8icd57r1c7QrNLrio=;
 b=pFockn/JE1rMxCwIc8CsG2PVy4MzcOv/GNP5+eA7sMxjSWot88p0tBlRzC8scyJBlzXZTL
 +J10VByxpmn2QL+WxAB0S48a1X6keyPzu0FwTXe+P9uPnQfaPyJ9jYfCIfE0ZjuACSftyJ
 H+vzRNO5h6u/K5Cq1/DXEGwJos+UuUs=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVwAI1hSkCaUpLf6ewphBAqD/y8icd57r1c7QrNLrio=;
 b=lUdjYZKfW0xSceH0I10RGjE9R5CVpGBjpZLKntbuwway5jEjevayT5G+8Q+KL120cphCpb
 qCGdRQAy0+RVI1bDc5ExsXUHkeU50WtH02ods4kPUhcuEPYRPWlZc65NwMZpsLC0RhfERE
 ZUAtutiOJSCXwtbOoIkkPrm6NImlaqM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92B81779BA;
 Fri, 24 Jul 2026 13:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6GnKGrVpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:41 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:17 +0200
Message-ID: <20260724133328.1837318-2-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[12];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Headers-End: 1wnHzp-0007tX-7x
Subject: [f2fs-dev] [PATCH 01/12] common/encrypt: separate data and inode
 nonces
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
From: Daniel Vacek via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Vacek <neelx@suse.com>
Cc: hch@infradead.org, Daniel Vacek <neelx@suse.com>, djwong@kernel.org,
 zlang@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 linux-fscrypt@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

btrfs will have different inode and data nonces, so we need to be
specific about which nonce each use needs. For now, there is no
difference in the two functions.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/encrypt    | 33 ++++++++++++++++++++++++++-------
 tests/f2fs/002    |  2 +-
 tests/generic/613 |  4 ++--
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index c9e0853d..8f664518 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -548,7 +548,7 @@ _add_fscrypt_provisioning_key()
 # Retrieve the encryption nonce of the given inode as a hex string.  The nonce
 # was randomly generated by the filesystem and isn't exposed directly to
 # userspace.  But it can be read using the filesystem's debugging tools.
-_get_encryption_nonce()
+_get_encryption_file_nonce()
 {
 	local device=$1
 	local inode=$2
@@ -592,15 +592,34 @@ _get_encryption_nonce()
 			}'
 		;;
 	*)
-		_fail "_get_encryption_nonce() isn't implemented on $FSTYP"
+		_fail "_get_encryption_file_nonce() isn't implemented on $FSTYP"
 		;;
 	esac
 }
 
-# Require support for _get_encryption_nonce()
+# Retrieve the encryption nonce used to encrypt the data of the given inode as
+# a hex string.  The nonce was randomly generated by the filesystem and isn't
+# exposed directly to userspace.  But it can be read using the filesystem's
+# debugging tools.
+_get_encryption_data_nonce()
+{
+	local device=$1
+	local inode=$2
+
+	case $FSTYP in
+	ext4|f2fs)
+		_get_encryption_file_nonce $device $inode
+		;;
+	*)
+		_fail "_get_encryption_data_nonce() isn't implemented on $FSTYP"
+		;;
+	esac
+}
+
+# Require support for _get_encryption_*nonce()
 _require_get_encryption_nonce_support()
 {
-	echo "Checking for _get_encryption_nonce() support for $FSTYP" >> $seqres.full
+	echo "Checking for _get_encryption_*nonce() support for $FSTYP" >> $seqres.full
 	case $FSTYP in
 	ext4)
 		_require_command "$DEBUGFS_PROG" debugfs
@@ -614,7 +633,7 @@ _require_get_encryption_nonce_support()
 		# the test fail in that case, as it was an f2fs-tools bug...
 		;;
 	*)
-		_notrun "_get_encryption_nonce() isn't implemented on $FSTYP"
+		_notrun "_get_encryption_*nonce() isn't implemented on $FSTYP"
 		;;
 	esac
 }
@@ -827,7 +846,7 @@ _do_verify_ciphertext_for_encryption_policy()
 	echo "Verifying encrypted file contents" >> $seqres.full
 	for f in "${test_contents_files[@]}"; do
 		read -r src inode blocklist <<< "$f"
-		nonce=$(_get_encryption_nonce $SCRATCH_DEV $inode)
+		nonce=$(_get_encryption_data_nonce $SCRATCH_DEV $inode)
 		_dump_ciphertext_blocks $SCRATCH_DEV $blocklist > $tmp.actual_contents
 		$crypt_contents_cmd $contents_encryption_mode $raw_key_hex \
 			--file-nonce=$nonce --inode-number=$inode \
@@ -846,7 +865,7 @@ _do_verify_ciphertext_for_encryption_policy()
 	echo "Verifying encrypted file names" >> $seqres.full
 	for f in "${test_filenames_files[@]}"; do
 		read -r name inode dir_inode padding <<< "$f"
-		nonce=$(_get_encryption_nonce $SCRATCH_DEV $dir_inode)
+		nonce=$(_get_encryption_file_nonce $SCRATCH_DEV $dir_inode)
 		_get_ciphertext_filename $SCRATCH_DEV $inode $dir_inode \
 			> $tmp.actual_name
 		echo -n "$name" | \
diff --git a/tests/f2fs/002 b/tests/f2fs/002
index d2f6e413..ec83c81b 100755
--- a/tests/f2fs/002
+++ b/tests/f2fs/002
@@ -126,7 +126,7 @@ blocklist=$(_get_ciphertext_block_list $file)
 _scratch_unmount
 
 echo -e "\n# Getting file's encryption nonce"
-nonce=$(_get_encryption_nonce $SCRATCH_DEV $inode)
+nonce=$(_get_encryption_data_nonce $SCRATCH_DEV $inode)
 
 echo -e "\n# Dumping the file's raw data"
 _dump_ciphertext_blocks $SCRATCH_DEV $blocklist > $tmp.raw
diff --git a/tests/generic/613 b/tests/generic/613
index 499af18e..6a120c13 100755
--- a/tests/generic/613
+++ b/tests/generic/613
@@ -66,10 +66,10 @@ echo -e "\n# Getting encryption nonces from inodes"
 echo -n > $tmp.nonces_hex
 echo -n > $tmp.nonces_bin
 for inode in "${inodes[@]}"; do
-	nonce=$(_get_encryption_nonce $SCRATCH_DEV $inode)
+	nonce=$(_get_encryption_data_nonce $SCRATCH_DEV $inode)
 	if (( ${#nonce} != 32 )) || [ -n "$(echo "$nonce" | tr -d 0-9a-fA-F)" ]
 	then
-		_fail "Expected nonce to be 16 bytes (32 hex characters), but got \"$nonce\""
+		_fail "Expected nonce for inode $inode to be 16 bytes (32 hex characters), but got \"$nonce\""
 	fi
 	echo $nonce >> $tmp.nonces_hex
 	echo -ne "$(echo $nonce | sed 's/[0-9a-fA-F]\{2\}/\\x\0/g')" \
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
