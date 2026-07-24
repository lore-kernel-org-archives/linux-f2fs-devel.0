Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADF3C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VIvVpGKBTCwPh/7Z7e1VoUyXceMjOSPuL2C0cRxCGsc=; b=MI87WI9wAxOFUFKjE5HSdfyOPM
	9PnmrmFkD3PdwC5dhD9JYTCGaLeEWrXCM22Ttu/kXkteFlbEMTzK2A1LlI2pEdOd5Q40/E2uAzK8w
	wLym3zmOhBGhce5mYoJ8LH1eYcccu/NzY5xRFu/XPOwnrfZ0iMN/6kIaYHYlWOXAqnBE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIHK-0005w0-OL;
	Fri, 24 Jul 2026 15:57:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnIHJ-0005vu-KM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wHYzh95fp5Ho3waLGLALi8fDx3ZIDOeiqjyS1BQ77MA=; b=PkhWEeh5frrCnncxRK6NuUDU/O
 C4z7Q5oztKxJFins43PHe+GspGlGv645zU3+xqngDDykvSqKlUs0suqoodo7zLuWccv0a0mv1opFj
 +nBteyxqATCEheyoAcsAiSu+x+XShJyaSHYEeArqLyRdY4xlYva0k1nv7wB6GLVDg0yQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wHYzh95fp5Ho3waLGLALi8fDx3ZIDOeiqjyS1BQ77MA=; b=Ow+5I5Jt1eWxo5R6N6MzkLOgU7
 NmIzJiXlZaYSXRUjLjCnoLTrICxJ6RKFmctzp9edtdnC/rn/49dd8OE3z2pde9T9gYWBmtqqsINSn
 rbJso6+ceEF0qjincsG25Quosmlo673YtqiI0K1CNxgFT7C1fcTKxLRcIoCAEJcvSBSc=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIHF-0000Se-Ee for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:57:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E75AC7B88D;
 Fri, 24 Jul 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHYzh95fp5Ho3waLGLALi8fDx3ZIDOeiqjyS1BQ77MA=;
 b=lWjEejBT2lAlSm/BCIaA4PDeqUUcT3JmOv/bu/KJDFYiTNi9ZleVHh/NsAgTqNB7LYo3Tx
 ANiprnlza9lVTm6RcLERjq0P4JCuepKfH67HjggfgbYFLob2WuP9sV0VDSehOI3dQGWK5V
 ttSWMMRJRnZlcQZP0R0p9mnaj3Sb21I=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=oxP8WtU5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHYzh95fp5Ho3waLGLALi8fDx3ZIDOeiqjyS1BQ77MA=;
 b=oxP8WtU5c9OkZtG/R65GRRQn+WXEJSkGHuUIB1LALz78yMXKEMZWFYHMB+rqXyoIsoPakb
 e+pKLAdx+M+t4wpXckzDkt3A7th7T89KO2urbmQrTQWkl37fksTpbXpQmyfJgtKUye49Ya
 z76VlKsWhLiTPAUzqznize855s+b+4Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B300779C4;
 Fri, 24 Jul 2026 13:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cGJzCsBpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:52 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:28 +0200
Message-ID: <20260724133328.1837318-13-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 R_RATELIMIT(0.00)[to_ip_from(RLqxq1d8k46pqxsbwde44x1q39)];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: E75AC7B88D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Headers-End: 1wnIHF-0000Se-Ee
Subject: [f2fs-dev] [PATCH 12/12] fscrypt-crypt-util: add support for per
 extent KDF
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
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 David Sterba <dsterba@suse.com>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When deriving a key for extent, fscrypt uses different salt. Add the
support for this.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/encrypt           | 13 +++++++++----
 src/fscrypt-crypt-util.c | 12 +++++++++++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index 4c3fd904..2485b69a 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -836,7 +836,7 @@ _do_verify_ciphertext_for_encryption_policy()
 	local blocksize=$(_get_block_size $SCRATCH_MNT)
 	local test_contents_files=()
 	local test_filenames_files=()
-	local i src dir dst inode blocklist \
+	local i src dir dst inode blocklist context_per_extent \
 	      padding_flag padding dir_inode len name f nonce decrypted_name
 
 	# Create files whose encrypted contents we'll verify.  For each, save
@@ -891,19 +891,24 @@ _do_verify_ciphertext_for_encryption_policy()
 	# Now unmount the filesystem and verify the ciphertext we just wrote.
 	_scratch_unmount
 
+	case $FSTYP in
+	btrfs)	context_per_extent=--context-per-extent;;
+	*)	context_per_extent=;;
+	esac
+
 	echo "Verifying encrypted file contents" >> $seqres.full
 	for f in "${test_contents_files[@]}"; do
 		read -r src inode blocklist <<< "$f"
 		nonce=$(_get_encryption_data_nonce $SCRATCH_DEV $inode)
 		_dump_ciphertext_blocks $SCRATCH_DEV $blocklist > $tmp.actual_contents
 		$crypt_contents_cmd $contents_encryption_mode $raw_key_hex \
-			--file-nonce=$nonce --inode-number=$inode \
-                        < $src > $tmp.expected_contents
+			--file-nonce=$nonce $context_per_extent --inode-number=$inode \
+			< $src > $tmp.expected_contents
 		if ! cmp $tmp.expected_contents $tmp.actual_contents; then
 			_fail "Expected encrypted contents != actual encrypted contents.  File: $f"
 		fi
 		$crypt_contents_cmd $contents_encryption_mode $raw_key_hex \
-			--decrypt --file-nonce=$nonce --inode-number=$inode \
+			--decrypt --file-nonce=$nonce $context_per_extent --inode-number=$inode \
 			< $tmp.actual_contents > $tmp.decrypted_contents
 		if ! cmp $src $tmp.decrypted_contents; then
 			_fail "Contents decryption sanity check failed.  File: $f"
diff --git a/src/fscrypt-crypt-util.c b/src/fscrypt-crypt-util.c
index f51b3669..1403edb5 100644
--- a/src/fscrypt-crypt-util.c
+++ b/src/fscrypt-crypt-util.c
@@ -75,6 +75,7 @@ static void usage(FILE *fp)
 "                                replicate the en/decryption that is done when\n"
 "                                the filesystem is given a hardware-wrapped key.\n"
 "  --file-nonce=NONCE          File's nonce as a 32-character hex string\n"
+"  --context-per-extent        Derive the key for per extent context.\n"
 "  --fs-uuid=UUID              The filesystem UUID as a 32-character hex string.\n"
 "                                Required for --iv-ino-lblk-32 and\n"
 "                                --iv-ino-lblk-64; otherwise is unused.\n"
@@ -2162,6 +2163,7 @@ struct key_and_iv_params {
 	bool direct_key;
 	bool iv_ino_lblk_64;
 	bool iv_ino_lblk_32;
+	bool context_per_extent;
 	u64 data_unit_index;
 	u64 inode_number;
 	u8 fs_uuid[UUID_SIZE];
@@ -2176,6 +2178,7 @@ struct key_and_iv_params {
 #define HKDF_CONTEXT_IV_INO_LBLK_32_KEY	6
 #define HKDF_CONTEXT_INODE_HASH_KEY	7
 #define HKDF_CONTEXT_KEY_IDENTIFIER_FOR_HW_WRAPPED_KEY 8
+#define HKDF_CONTEXT_PER_EXTENT_ENC_KEY	9
 
 /* Hash the file's inode number using SipHash keyed by a derived key */
 static u32 hash_inode_number(const struct key_and_iv_params *params)
@@ -2366,7 +2369,9 @@ static void derive_real_key(const struct key_and_iv_params *params,
 		} else {
 			if (!params->file_nonce_specified)
 				die("--kdf=HKDF-SHA512 requires --file-nonce or --iv-ino-lblk-{64,32}");
-			info[infolen++] = HKDF_CONTEXT_PER_FILE_ENC_KEY;
+			info[infolen++] = params->context_per_extent?
+						HKDF_CONTEXT_PER_EXTENT_ENC_KEY:
+						HKDF_CONTEXT_PER_FILE_ENC_KEY;
 			memcpy(&info[infolen], params->file_nonce,
 			       FILE_NONCE_SIZE);
 			infolen += FILE_NONCE_SIZE;
@@ -2481,6 +2486,7 @@ enum {
 	OPT_DUMP_KEY_IDENTIFIER,
 	OPT_ENABLE_HW_KDF,
 	OPT_FILE_NONCE,
+	OPT_CONTEXT_PER_EXTENT,
 	OPT_FS_UUID,
 	OPT_HELP,
 	OPT_INODE_NUMBER,
@@ -2500,6 +2506,7 @@ static const struct option longopts[] = {
 	{ "dump-key-identifier", no_argument,   NULL, OPT_DUMP_KEY_IDENTIFIER },
 	{ "enable-hw-kdf",   no_argument,       NULL, OPT_ENABLE_HW_KDF },
 	{ "file-nonce",      required_argument, NULL, OPT_FILE_NONCE },
+	{ "context-per-extent", no_argument,    NULL, OPT_CONTEXT_PER_EXTENT },
 	{ "fs-uuid",         required_argument, NULL, OPT_FS_UUID },
 	{ "help",            no_argument,       NULL, OPT_HELP },
 	{ "inode-number",    required_argument, NULL, OPT_INODE_NUMBER },
@@ -2572,6 +2579,9 @@ int main(int argc, char *argv[])
 				die("Invalid file nonce: %s", optarg);
 			params.file_nonce_specified = true;
 			break;
+		case OPT_CONTEXT_PER_EXTENT:
+			params.context_per_extent = true;
+			break;
 		case OPT_FS_UUID:
 			if (hex2bin(optarg, params.fs_uuid, UUID_SIZE)
 			    != UUID_SIZE)
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
