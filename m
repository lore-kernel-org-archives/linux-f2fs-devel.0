Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAC3C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZGHbCOZahixHiQetRZTEzI7+x/dA2IUyjC5N4XNNhvA=; b=MSmB84U+Gnqr6u9USAmJ/5agu0
	K/qmzXQePwWiPgfyD/mW7eyDKAPhGGPM1gHVxeSc9WIYQMSncpDueuDJ7njn7o4/THA0lCpEzECnJ
	4dQVsDauZIEsVtalAEswTdfR3A5i6qQ8fgTrQFQ/vNrshHIUv+OD9lrEaL8+AMWYEZIk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIiP-0006iO-Gn;
	Fri, 24 Jul 2026 16:25:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnIiK-0006iF-MW
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6xS/Lga0yFdcsN8Y+aXgqdEfWltZwhv+FxiQQNzPLM=; b=lt5NJvKUDSpNEHYuLp3BYW6I9G
 1zzK2M4NUAehJX2mzFGsXuods4Og+byPGaayFfyIlIxHbns/jcLYL8eRj0Q44nQ/4lpvwQos4vn+I
 eUf8IeIPHEanhgRqKA0Rc8m/Awfhdul8NQKWWyxXtRCPhRqxarroaIkG2zrMfO2YpaL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j6xS/Lga0yFdcsN8Y+aXgqdEfWltZwhv+FxiQQNzPLM=; b=jjmwBFItCtEfNlqsbaGm84HD7E
 IK/fgqF6f9/CTpGSCQjiJBP4R23hH/8AnxNeXW+wOKb4UWLNbi9NwCj3qZXfu1RbazLYLPUR3AufE
 D8GzQjAalBUsA5z9rYMURJJREdrZqvoIpBxZ4n9EG43e4kNK2TzjuMFBbCe++RFJHcoE=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIiF-0001oV-Rk for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:25:30 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30A4E3F13;
 Fri, 24 Jul 2026 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6xS/Lga0yFdcsN8Y+aXgqdEfWltZwhv+FxiQQNzPLM=;
 b=fN2ah7r7TMGDPEHN7SNrYfaZ29zD9VEW6EqMz+RAv4UhQZX5e76wrR7ZUJx4zZtW7UR/cx
 +X7/6+IddbkSE0HAQAVyGhnTsPetWBhIa1mf3eZUzr+DkCKdhRioyorQPZWrqXDbtDD2ro
 5xTG+gEBOtZv3sFrgLGigLbTdQUQnBM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6xS/Lga0yFdcsN8Y+aXgqdEfWltZwhv+FxiQQNzPLM=;
 b=fN2ah7r7TMGDPEHN7SNrYfaZ29zD9VEW6EqMz+RAv4UhQZX5e76wrR7ZUJx4zZtW7UR/cx
 +X7/6+IddbkSE0HAQAVyGhnTsPetWBhIa1mf3eZUzr+DkCKdhRioyorQPZWrqXDbtDD2ro
 5xTG+gEBOtZv3sFrgLGigLbTdQUQnBM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82BD4779BA;
 Fri, 24 Jul 2026 13:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wOmUG71pY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:49 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:25 +0200
Message-ID: <20260724133328.1837318-10-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Headers-End: 1wnIiF-0001oV-Rk
Subject: [f2fs-dev] [PATCH 09/12] fstests: split generic/580 into two tests
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

generic/580 tests both v1 and v2 encryption policies, however btrfs only
supports v2 policies.  Split this into two tests so that we can get the
v2 coverage for btrfs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 tests/generic/580     | 118 ++++++++++++++++++------------------------
 tests/generic/580.out |  40 --------------
 tests/generic/798     |  77 +++++++++++++++++++++++++++
 tests/generic/798.out |  44 ++++++++++++++++
 4 files changed, 171 insertions(+), 108 deletions(-)
 create mode 100755 tests/generic/798
 create mode 100644 tests/generic/798.out

diff --git a/tests/generic/580 b/tests/generic/580
index eff3f210..848d083b 100755
--- a/tests/generic/580
+++ b/tests/generic/580
@@ -5,7 +5,7 @@
 # FS QA Test generic/580
 #
 # Basic test of the fscrypt filesystem-level encryption keyring
-# and v2 encryption policies.
+# policy.
 #
 
 . ./common/preamble
@@ -16,80 +16,62 @@ echo
 . ./common/filter
 . ./common/encrypt
 
-_require_scratch_encryption -v 2
+_require_scratch_encryption
 
 _scratch_mkfs_encrypted &>> $seqres.full
 _scratch_mount
 
-test_with_policy_version()
-{
-	local vers=$1
-
-	if (( vers == 1 )); then
-		local keyspec=$TEST_KEY_DESCRIPTOR
-		local add_enckey_args="-d $keyspec"
-	else
-		local keyspec=$TEST_KEY_IDENTIFIER
-		local add_enckey_args=""
-	fi
-
-	mkdir $dir
-	echo "# Setting v$vers encryption policy"
-	_set_encpolicy $dir $keyspec
-	echo "# Getting v$vers encryption policy"
-	_get_encpolicy $dir | _filter_scratch
-	if (( vers == 1 )); then
-		echo "# Getting v1 encryption policy using old ioctl"
-		_get_encpolicy $dir -1 | _filter_scratch
-	fi
-	echo "# Trying to create file without key added yet"
-	$XFS_IO_PROG -f $dir/file |& _filter_scratch
-	echo "# Getting encryption key status"
-	_enckey_status $SCRATCH_MNT $keyspec
-	echo "# Adding encryption key"
-	_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY" $add_enckey_args
-	echo "# Creating encrypted file"
-	echo contents > $dir/file
-	echo "# Getting encryption key status"
-	_enckey_status $SCRATCH_MNT $keyspec
-	echo "# Removing encryption key"
-	_rm_enckey $SCRATCH_MNT $keyspec
-	echo "# Getting encryption key status"
-	_enckey_status $SCRATCH_MNT $keyspec
-	echo "# Verifying that the encrypted directory was \"locked\""
-	cat $dir/file |& _filter_scratch
-	cat "$(find $dir -type f)" |& _filter_scratch | cut -d ' ' -f3-
-
-	# Test removing key with a file open.
-	echo "# Re-adding encryption key"
-	_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY" $add_enckey_args
-	echo "# Creating another encrypted file"
-	echo foo > $dir/file2
-	echo "# Removing key while an encrypted file is open"
-	exec 3< $dir/file
-	_rm_enckey $SCRATCH_MNT $keyspec
-	echo "# Non-open file should have been evicted"
-	cat $dir/file2 |& _filter_scratch
-	echo "# Open file shouldn't have been evicted"
-	cat $dir/file
-	echo "# Key should be in \"incompletely removed\" state"
-	_enckey_status $SCRATCH_MNT $keyspec
-	echo "# Closing file and removing key for real now"
-	exec 3<&-
-	_rm_enckey $SCRATCH_MNT $keyspec
-	cat $dir/file |& _filter_scratch
-
-	echo "# Cleaning up"
-	rm -rf $dir
-	_scratch_cycle_mount	# Clear all keys
-	echo
-}
-
 dir=$SCRATCH_MNT/dir
+keyspec=$TEST_KEY_DESCRIPTOR
+
+mkdir $dir
+echo "# Setting v1 encryption policy"
+_set_encpolicy $dir $keyspec
+echo "# Getting v1 encryption policy"
+_get_encpolicy $dir | _filter_scratch
+echo "# Getting v1 encryption policy using old ioctl"
+_get_encpolicy $dir -1 | _filter_scratch
+echo "# Trying to create file without key added yet"
+$XFS_IO_PROG -f $dir/file |& _filter_scratch
+echo "# Getting encryption key status"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Adding encryption key"
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY" -d $keyspec
+echo "# Creating encrypted file"
+echo contents > $dir/file
+echo "# Getting encryption key status"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Removing encryption key"
+_rm_enckey $SCRATCH_MNT $keyspec
+echo "# Getting encryption key status"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Verifying that the encrypted directory was \"locked\""
+cat $dir/file |& _filter_scratch
+cat "$(find $dir -type f)" |& _filter_scratch | cut -d ' ' -f3-
 
-test_with_policy_version 1
+# Test removing key with a file open.
+echo "# Re-adding encryption key"
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY" -d $keyspec
+echo "# Creating another encrypted file"
+echo foo > $dir/file2
+echo "# Removing key while an encrypted file is open"
+exec 3< $dir/file
+_rm_enckey $SCRATCH_MNT $keyspec
+echo "# Non-open file should have been evicted"
+cat $dir/file2 |& _filter_scratch
+echo "# Open file shouldn't have been evicted"
+cat $dir/file
+echo "# Key should be in \"incompletely removed\" state"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Closing file and removing key for real now"
+exec 3<&-
+_rm_enckey $SCRATCH_MNT $keyspec
+cat $dir/file |& _filter_scratch
 
-test_with_policy_version 2
+echo "# Cleaning up"
+rm -rf $dir
+_scratch_cycle_mount	# Clear all keys
+echo
 
 echo "# Trying to remove absent key"
 _rm_enckey $SCRATCH_MNT abcdabcdabcdabcd
diff --git a/tests/generic/580.out b/tests/generic/580.out
index 989d4514..f2f4d490 100644
--- a/tests/generic/580.out
+++ b/tests/generic/580.out
@@ -47,45 +47,5 @@ Removed encryption key with descriptor 0000111122223333
 cat: SCRATCH_MNT/dir/file: No such file or directory
 # Cleaning up
 
-# Setting v2 encryption policy
-# Getting v2 encryption policy
-Encryption policy for SCRATCH_MNT/dir:
-	Policy version: 2
-	Master key identifier: 69b2f6edeee720cce0577937eb8a6751
-	Contents encryption mode: 1 (AES-256-XTS)
-	Filenames encryption mode: 4 (AES-256-CTS)
-	Flags: 0x02
-# Trying to create file without key added yet
-SCRATCH_MNT/dir/file: Required key not available
-# Getting encryption key status
-Absent
-# Adding encryption key
-Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Creating encrypted file
-# Getting encryption key status
-Present (user_count=1, added_by_self)
-# Removing encryption key
-Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Getting encryption key status
-Absent
-# Verifying that the encrypted directory was "locked"
-cat: SCRATCH_MNT/dir/file: No such file or directory
-Required key not available
-# Re-adding encryption key
-Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-# Creating another encrypted file
-# Removing key while an encrypted file is open
-Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751, but files still busy
-# Non-open file should have been evicted
-cat: SCRATCH_MNT/dir/file2: Required key not available
-# Open file shouldn't have been evicted
-contents
-# Key should be in "incompletely removed" state
-Incompletely removed
-# Closing file and removing key for real now
-Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
-cat: SCRATCH_MNT/dir/file: No such file or directory
-# Cleaning up
-
 # Trying to remove absent key
 Error removing encryption key: Required key not available
diff --git a/tests/generic/798 b/tests/generic/798
new file mode 100755
index 00000000..e2bbaade
--- /dev/null
+++ b/tests/generic/798
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test generic/798
+#
+# A v2 only version of generic/580
+
+. ./common/preamble
+_begin_fstest auto quick encrypt
+echo
+
+# Import common functions.
+. ./common/filter
+. ./common/encrypt
+
+_require_scratch_encryption -v 2
+
+_scratch_mkfs_encrypted &>> $seqres.full
+_scratch_mount
+
+keyspec=$TEST_KEY_IDENTIFIER
+dir=$SCRATCH_MNT/dir
+
+mkdir $dir
+echo "# Setting v2 encryption policy"
+_set_encpolicy $dir $keyspec
+echo "# Getting v2 encryption policy"
+_get_encpolicy $dir | _filter_scratch
+echo "# Trying to create file without key added yet"
+$XFS_IO_PROG -f $dir/file |& _filter_scratch
+echo "# Getting encryption key status"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Adding encryption key"
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+echo "# Creating encrypted file"
+echo contents > $dir/file
+echo "# Getting encryption key status"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Removing encryption key"
+_rm_enckey $SCRATCH_MNT $keyspec
+echo "# Getting encryption key status"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Verifying that the encrypted directory was \"locked\""
+cat $dir/file |& _filter_scratch
+cat "$(find $dir -type f)" |& _filter_scratch | cut -d ' ' -f3-
+
+# Test removing key with a file open.
+echo "# Re-adding encryption key"
+_add_enckey $SCRATCH_MNT "$TEST_RAW_KEY"
+echo "# Creating another encrypted file"
+echo foo > $dir/file2
+echo "# Removing key while an encrypted file is open"
+exec 3< $dir/file
+_rm_enckey $SCRATCH_MNT $keyspec
+echo "# Non-open file should have been evicted"
+cat $dir/file2 |& _filter_scratch
+echo "# Open file shouldn't have been evicted"
+cat $dir/file
+echo "# Key should be in \"incompletely removed\" state"
+_enckey_status $SCRATCH_MNT $keyspec
+echo "# Closing file and removing key for real now"
+exec 3<&-
+_rm_enckey $SCRATCH_MNT $keyspec
+cat $dir/file |& _filter_scratch
+
+echo "# Cleaning up"
+rm -rf $dir
+_scratch_cycle_mount	# Clear all keys
+echo
+
+echo "# Trying to remove absent key"
+_rm_enckey $SCRATCH_MNT abcdabcdabcdabcd
+
+# success, all done
+status=0
+exit
+
diff --git a/tests/generic/798.out b/tests/generic/798.out
new file mode 100644
index 00000000..b1f64e29
--- /dev/null
+++ b/tests/generic/798.out
@@ -0,0 +1,44 @@
+QA output created by 798
+
+# Setting v2 encryption policy
+# Getting v2 encryption policy
+Encryption policy for SCRATCH_MNT/dir:
+	Policy version: 2
+	Master key identifier: 69b2f6edeee720cce0577937eb8a6751
+	Contents encryption mode: 1 (AES-256-XTS)
+	Filenames encryption mode: 4 (AES-256-CTS)
+	Flags: 0x02
+# Trying to create file without key added yet
+SCRATCH_MNT/dir/file: Required key not available
+# Getting encryption key status
+Absent
+# Adding encryption key
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Creating encrypted file
+# Getting encryption key status
+Present (user_count=1, added_by_self)
+# Removing encryption key
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Getting encryption key status
+Absent
+# Verifying that the encrypted directory was "locked"
+cat: SCRATCH_MNT/dir/file: No such file or directory
+Required key not available
+# Re-adding encryption key
+Added encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+# Creating another encrypted file
+# Removing key while an encrypted file is open
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751, but files still busy
+# Non-open file should have been evicted
+cat: SCRATCH_MNT/dir/file2: Required key not available
+# Open file shouldn't have been evicted
+contents
+# Key should be in "incompletely removed" state
+Incompletely removed
+# Closing file and removing key for real now
+Removed encryption key with identifier 69b2f6edeee720cce0577937eb8a6751
+cat: SCRATCH_MNT/dir/file: No such file or directory
+# Cleaning up
+
+# Trying to remove absent key
+Error removing encryption key: Required key not available
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
