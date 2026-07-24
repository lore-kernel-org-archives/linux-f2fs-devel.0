Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43795C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/u/yEx4bLjOmxYra9Et9claU2EbCaIOzJ1PHAg1mb2Q=; b=dPAe11H/e6OYoxI9W/jaVUq2v5
	/Z/TM0dXIJgLOpRFMmwMxBcjknN6llx8Irzud9sD2U+SCiDQBnJcJz38En445S5wfbO3JaSDuLM/D
	G+O69t2E4EjBRSBGxl1UddjGK3SCs7CO6ISdvbAJFH+K8XEQPdJa23pae9ehCBBf8ICc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnI1j-0006fp-Qo;
	Fri, 24 Jul 2026 15:41:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnI1h-0006fd-8w
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1UWnyET4pT6RB5xPBJTqDzHHSdPxhb8Yxe3isstMQCo=; b=FyTTTpGld97nRIW+rDmLcOJfnT
 i1hyTAjqMoIJKmWw4VDOdOX7GGM+6Xgo7kz8HRPCoDpLNedBsWOJ8sHiFARtbnNEc3vo69/i3mgOw
 7BMCQ5kB7jLRM5M4Y1bRSOI59Ch7JH2ZXEKob1szFLeaVCZRhnQd6dggXnxFW7/OxbEs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1UWnyET4pT6RB5xPBJTqDzHHSdPxhb8Yxe3isstMQCo=; b=QbRABETcWfEbpdKKOiri0Z0VJS
 MxOjxvsCV2DAd5FNj2KNhDQkppUJs84pqMW6YsUUk+tjcVDsQQD+XYYCGCE2uSatZxjNlKAP6cHOq
 Fhd9y8yGtB+1OKY2Le5FVHOrZA63HeTXglHKOnwZgbUSkR70iDvpoC+GWZUhQteNyikU=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnI1g-000820-2J for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:41:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6377B3F6C;
 Fri, 24 Jul 2026 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UWnyET4pT6RB5xPBJTqDzHHSdPxhb8Yxe3isstMQCo=;
 b=AZNqrtRCEK/ILYSxjKmuRscbGIrJh+4w1mH5DkBhhFmIEOSVs2zGNC3+yi2oY3nWwWCHUR
 7Aca6dISxb3SSKM3Tvuyktj/+t7mm+/rTBD5oh41DEvnmY01qXYv5SgclCO1Q/hhY1EgRR
 uDrrxr/rUWTcHkaV5DvJzX/fIvFN+PY=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=oPOgKidH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UWnyET4pT6RB5xPBJTqDzHHSdPxhb8Yxe3isstMQCo=;
 b=oPOgKidHyZ/tOwhdjauTRtOaf6bko8KotMFSwKJqRZKRrRXb66tZMdnPL/ztKTU0ixrtun
 IWCiipnPGaJ3pQf+Uh6MpqBJi7U3x+eWCiQZpY5QSiASJTOnvV6Q9aGMqBfID5foo37XJg
 aaikfEmsrakG6ytio60iIj6svQsnmj8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E630779C3;
 Fri, 24 Jul 2026 13:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mItgDb5pY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:50 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:26 +0200
Message-ID: <20260724133328.1837318-11-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 6377B3F6C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Headers-End: 1wnI1g-000820-2J
Subject: [f2fs-dev] [PATCH 10/12] fstests: split generic/581 into two tests
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
 zlang@redhat.com, Josef Bacik <josef@toxicpanda.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, David Sterba <dsterba@suse.com>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Josef Bacik <josef@toxicpanda.com>

generic/581 is mostly a v2 policy test, but it does do some quick checks
of v1 policies as a normal user.  Split the v1 and v2 related parts
into two different tests so that the v2 part can get properly tested for
btrfs file systems, which only support v2 policies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 tests/generic/581     |  89 +---------------------------
 tests/generic/581.out |  50 ----------------
 tests/generic/799     | 132 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/799.out |  51 ++++++++++++++++
 4 files changed, 185 insertions(+), 137 deletions(-)
 create mode 100755 tests/generic/799
 create mode 100644 tests/generic/799.out

diff --git a/tests/generic/581 b/tests/generic/581
index 2773c910..d39cee24 100755
--- a/tests/generic/581
+++ b/tests/generic/581
@@ -4,8 +4,7 @@
 #
 # FS QA Test No. generic/581
 #
-# Test non-root use of the fscrypt filesystem-level encryption keyring
-# and v2 encryption policies.
+# Test non-root use of the fscrypt filesystem-level encryption keyring policy.
 #
 
 . ./common/preamble
@@ -29,7 +28,7 @@ _cleanup()
 . ./common/encrypt
 
 _require_user
-_require_scratch_encryption -v 2
+_require_scratch_encryption
 
 _scratch_mkfs_encrypted &>> $seqres.full
 _scratch_mount
@@ -56,90 +55,6 @@ echo "# Adding v1 policy key as regular user (should fail with EACCES)"
 _user_do_add_enckey $SCRATCH_MNT "$raw_key" -d $keydesc
 
 rm -rf $dir
-echo
-_user_do "mkdir $dir"
-
-echo "# Setting v2 policy as regular user without key already added (should fail with ENOKEY)"
-_user_do_set_encpolicy $dir $keyid |& _filter_scratch
-
-echo "# Adding v2 policy key as regular user (should succeed)"
-_user_do_add_enckey $SCRATCH_MNT "$raw_key"
-
-echo "# Setting v2 policy as regular user with key added (should succeed)"
-_user_do_set_encpolicy $dir $keyid
-
-echo "# Getting v2 policy as regular user (should succeed)"
-_user_do_get_encpolicy $dir | _filter_scratch
-
-echo "# Creating encrypted file as regular user (should succeed)"
-_user_do "echo contents > $dir/file"
-
-echo "# Removing v2 policy key as regular user (should succeed)"
-_user_do_rm_enckey $SCRATCH_MNT $keyid
-
-_scratch_cycle_mount	# Clear all keys
-
-# Wait for any invalidated keys to be garbage-collected.
-i=0
-while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys; do
-	if ((++i >= 20)); then
-		echo "Timed out waiting for invalidated keys to be GC'ed" >> $seqres.full
-		break
-	fi
-	sleep 0.5
-done
-
-# Set the user key quota to the fsgqa user's current number of keys plus 5.
-orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
-: ${orig_keys:=0}
-echo "orig_keys=$orig_keys" >> $seqres.full
-orig_maxkeys=$(</proc/sys/kernel/keys/maxkeys)
-keys_to_add=5
-echo $((orig_keys + keys_to_add)) > /proc/sys/kernel/keys/maxkeys
-
-echo
-echo "# Testing user key quota"
-for i in `seq $((keys_to_add + 1))`; do
-	rand_raw_key=$(_generate_raw_encryption_key)
-	_user_do_add_enckey $SCRATCH_MNT "$rand_raw_key" \
-	    | sed 's/ with identifier .*$//'
-done
-
-# Restore the original key quota.
-echo "$orig_maxkeys" > /proc/sys/kernel/keys/maxkeys
-
-rm -rf $dir
-echo
-_user_do "mkdir $dir"
-_scratch_cycle_mount	# Clear all keys
-
-# Test multiple users adding the same key.
-echo "# Adding key as root"
-_add_enckey $SCRATCH_MNT "$raw_key"
-echo "# Getting key status as regular user"
-_user_do_enckey_status $SCRATCH_MNT $keyid
-echo "# Removing key only added by another user (should fail with ENOKEY)"
-_user_do_rm_enckey $SCRATCH_MNT $keyid
-echo "# Setting v2 encryption policy with key only added by another user (should fail with ENOKEY)"
-_user_do_set_encpolicy $dir $keyid |& _filter_scratch
-echo "# Adding second user of key"
-_user_do_add_enckey $SCRATCH_MNT "$raw_key"
-echo "# Getting key status as regular user"
-_user_do_enckey_status $SCRATCH_MNT $keyid
-echo "# Setting v2 encryption policy as regular user"
-_user_do_set_encpolicy $dir $keyid
-echo "# Removing this user's claim to the key"
-_user_do_rm_enckey $SCRATCH_MNT $keyid
-echo "# Getting key status as regular user"
-_user_do_enckey_status $SCRATCH_MNT $keyid
-echo "# Adding back second user of key"
-_user_do_add_enckey $SCRATCH_MNT "$raw_key"
-echo "# Remove key for \"all users\", as regular user (should fail with EACCES)"
-_user_do_rm_enckey $SCRATCH_MNT $keyid -a |& _filter_scratch
-_enckey_status $SCRATCH_MNT $keyid
-echo "# Remove key for \"all users\", as root"
-_rm_enckey $SCRATCH_MNT $keyid -a
-_enckey_status $SCRATCH_MNT $keyid
 
 # success, all done
 status=0
diff --git a/tests/generic/581.out b/tests/generic/581.out
index b3f7d889..a8cb96a8 100644
--- a/tests/generic/581.out
+++ b/tests/generic/581.out
@@ -10,53 +10,3 @@ Encryption policy for SCRATCH_MNT/dir:
 	Flags: 0x02
 # Adding v1 policy key as regular user (should fail with EACCES)
 Permission denied
-
-# Setting v2 policy as regular user without key already added (should fail with ENOKEY)
-SCRATCH_MNT/dir: failed to set encryption policy: Required key not available
-# Adding v2 policy key as regular user (should succeed)
-Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Setting v2 policy as regular user with key added (should succeed)
-# Getting v2 policy as regular user (should succeed)
-Encryption policy for SCRATCH_MNT/dir:
-	Policy version: 2
-	Master key identifier: 69b2f6edeee720cce0577937eb8a6751
-	Contents encryption mode: 1 (AES-256-XTS)
-	Filenames encryption mode: 4 (AES-256-CTS)
-	Flags: 0x02
-# Creating encrypted file as regular user (should succeed)
-# Removing v2 policy key as regular user (should succeed)
-Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-
-# Testing user key quota
-Added encryption key
-Added encryption key
-Added encryption key
-Added encryption key
-Added encryption key
-Error adding encryption key: Disk quota exceeded
-
-# Adding key as root
-Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Getting key status as regular user
-Present (user_count=1)
-# Removing key only added by another user (should fail with ENOKEY)
-Error removing encryption key: Required key not available
-# Setting v2 encryption policy with key only added by another user (should fail with ENOKEY)
-SCRATCH_MNT/dir: failed to set encryption policy: Required key not available
-# Adding second user of key
-Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Getting key status as regular user
-Present (user_count=2, added_by_self)
-# Setting v2 encryption policy as regular user
-# Removing this user's claim to the key
-Removed user's claim to encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Getting key status as regular user
-Present (user_count=1)
-# Adding back second user of key
-Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Remove key for "all users", as regular user (should fail with EACCES)
-Permission denied
-Present (user_count=2, added_by_self)
-# Remove key for "all users", as root
-Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-Absent
diff --git a/tests/generic/799 b/tests/generic/799
new file mode 100755
index 00000000..ac2f6154
--- /dev/null
+++ b/tests/generic/799
@@ -0,0 +1,132 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Google LLC
+#
+# FS QA Test No. generic/799
+#
+# Test non-root use of the fscrypt filesystem-level encryption v2 policy.
+#
+
+. ./common/preamble
+_begin_fstest auto quick encrypt
+echo
+
+orig_maxkeys=
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	if [ -n "$orig_maxkeys" ]; then
+		echo "$orig_maxkeys" > /proc/sys/kernel/keys/maxkeys
+	fi
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+_require_user
+_require_scratch_encryption -v 2
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+dir=$SCRATCH_MNT/dir
+
+raw_key=""
+for i in `seq 64`; do
+	raw_key+="\\x$(printf "%02x" $i)"
+done
+keydesc="0000111122223333"
+keyid="69b2f6edeee720cce0577937eb8a6751"
+chmod 777 $SCRATCH_MNT
+
+_user_do "mkdir $dir"
+
+echo "# Setting v2 policy as regular user without key already added (should fail with ENOKEY)"
+_user_do_set_encpolicy $dir $keyid |& _filter_scratch
+
+echo "# Adding v2 policy key as regular user (should succeed)"
+_user_do_add_enckey $SCRATCH_MNT "$raw_key"
+
+echo "# Setting v2 policy as regular user with key added (should succeed)"
+_user_do_set_encpolicy $dir $keyid
+
+echo "# Getting v2 policy as regular user (should succeed)"
+_user_do_get_encpolicy $dir | _filter_scratch
+
+echo "# Creating encrypted file as regular user (should succeed)"
+_user_do "echo contents > $dir/file"
+
+echo "# Removing v2 policy key as regular user (should succeed)"
+_user_do_rm_enckey $SCRATCH_MNT $keyid
+
+_scratch_cycle_mount	# Clear all keys
+
+# Wait for any invalidated keys to be garbage-collected.
+i=0
+while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys; do
+	if ((++i >= 20)); then
+		echo "Timed out waiting for invalidated keys to be GC'ed" >> $seqres.full
+		break
+	fi
+	sleep 0.5
+done
+
+# Set the user key quota to the fsgqa user's current number of keys plus 5.
+orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
+: ${orig_keys:=0}
+echo "orig_keys=$orig_keys" >> $seqres.full
+orig_maxkeys=$(</proc/sys/kernel/keys/maxkeys)
+keys_to_add=5
+echo $((orig_keys + keys_to_add)) > /proc/sys/kernel/keys/maxkeys
+
+echo
+echo "# Testing user key quota"
+for i in `seq $((keys_to_add + 1))`; do
+	rand_raw_key=$(_generate_raw_encryption_key)
+	_user_do_add_enckey $SCRATCH_MNT "$rand_raw_key" \
+	    | sed 's/ with identifier .*$//'
+done
+
+# Restore the original key quota.
+echo "$orig_maxkeys" > /proc/sys/kernel/keys/maxkeys
+
+rm -rf $dir
+echo
+_user_do "mkdir $dir"
+_scratch_cycle_mount	# Clear all keys
+
+# Test multiple users adding the same key.
+echo "# Adding key as root"
+_add_enckey $SCRATCH_MNT "$raw_key"
+echo "# Getting key status as regular user"
+_user_do_enckey_status $SCRATCH_MNT $keyid
+echo "# Removing key only added by another user (should fail with ENOKEY)"
+_user_do_rm_enckey $SCRATCH_MNT $keyid
+echo "# Setting v2 encryption policy with key only added by another user (should fail with ENOKEY)"
+_user_do_set_encpolicy $dir $keyid |& _filter_scratch
+echo "# Adding second user of key"
+_user_do_add_enckey $SCRATCH_MNT "$raw_key"
+echo "# Getting key status as regular user"
+_user_do_enckey_status $SCRATCH_MNT $keyid
+echo "# Setting v2 encryption policy as regular user"
+_user_do_set_encpolicy $dir $keyid
+echo "# Removing this user's claim to the key"
+_user_do_rm_enckey $SCRATCH_MNT $keyid
+echo "# Getting key status as regular user"
+_user_do_enckey_status $SCRATCH_MNT $keyid
+echo "# Adding back second user of key"
+_user_do_add_enckey $SCRATCH_MNT "$raw_key"
+echo "# Remove key for \"all users\", as regular user (should fail with EACCES)"
+_user_do_rm_enckey $SCRATCH_MNT $keyid -a |& _filter_scratch
+_enckey_status $SCRATCH_MNT $keyid
+echo "# Remove key for \"all users\", as root"
+_rm_enckey $SCRATCH_MNT $keyid -a
+_enckey_status $SCRATCH_MNT $keyid
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/799.out b/tests/generic/799.out
new file mode 100644
index 00000000..4e32a33c
--- /dev/null
+++ b/tests/generic/799.out
@@ -0,0 +1,51 @@
+QA output created by 799
+
+# Setting v2 policy as regular user without key already added (should fail with ENOKEY)
+SCRATCH_MNT/dir: failed to set encryption policy: Required key not available
+# Adding v2 policy key as regular user (should succeed)
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Setting v2 policy as regular user with key added (should succeed)
+# Getting v2 policy as regular user (should succeed)
+Encryption policy for SCRATCH_MNT/dir:
+	Policy version: 2
+	Master key identifier: 69b2f6edeee720cce0577937eb8a6751
+	Contents encryption mode: 1 (AES-256-XTS)
+	Filenames encryption mode: 4 (AES-256-CTS)
+	Flags: 0x02
+# Creating encrypted file as regular user (should succeed)
+# Removing v2 policy key as regular user (should succeed)
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+
+# Testing user key quota
+Added encryption key
+Added encryption key
+Added encryption key
+Added encryption key
+Added encryption key
+Error adding encryption key: Disk quota exceeded
+
+# Adding key as root
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Getting key status as regular user
+Present (user_count=1)
+# Removing key only added by another user (should fail with ENOKEY)
+Error removing encryption key: Required key not available
+# Setting v2 encryption policy with key only added by another user (should fail with ENOKEY)
+SCRATCH_MNT/dir: failed to set encryption policy: Required key not available
+# Adding second user of key
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Getting key status as regular user
+Present (user_count=2, added_by_self)
+# Setting v2 encryption policy as regular user
+# Removing this user's claim to the key
+Removed user's claim to encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Getting key status as regular user
+Present (user_count=1)
+# Adding back second user of key
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Remove key for "all users", as regular user (should fail with EACCES)
+Permission denied
+Present (user_count=2, added_by_self)
+# Remove key for "all users", as root
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+Absent
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
