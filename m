Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D916C531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcK9Gk6pyEqlr8A6f4nZRB2NY/7Ygwjjp7G6uWcntQo=; b=aGmCobcj5askEcp1NAZNSH2/FI
	p2liwQXYNWfissSrnXVaOWIx2c1EIwP/7rNo/AwWq5YvOndw6EVVmBvsOmrSyclzTTNUi03c5R7AV
	gespUFk4J789x3BD4rvK6AtY1W/fiFI+KYsY5g/XOmYEmsTXZ/m7c8KUraFEWJYqMD6w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIaa-0006Ub-2V;
	Fri, 24 Jul 2026 16:17:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnIaY-0006UT-NX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9yQzSswFScmj62SxMmGeKfmLmVtIzb7p3u1YSeUWdEI=; b=WGMbq7fKDPbP8n3Vz7HCVfhVQO
 VsONDce6+qDd/sao7WEFieh22JHld6Ik8f5XP628ydEE4FmVmDXFdgt15L6X7vX2BPLYM9UWlI69m
 0pJ4vv/3J0AgRT0TylY7ZfaNyaZOJaF03ixzJrSMG6Fv7Fc+XbcEOXgUTC63R/W+mh+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9yQzSswFScmj62SxMmGeKfmLmVtIzb7p3u1YSeUWdEI=; b=FRooOKR7k5uEvu7lXJw2UCUJsz
 /QAoJJUpwzpddwKG4BO27g4CkiEGrX6SCUcHf1VZBh7K2ysKuSYU5F/IR7sp20pnE6Zl6dtsS5RFl
 jFr8vuL6IQ/mTzmMbLlm1zETdJ79Z7vHOhq/YmNxod32xAEanE7I8dkfg8sNBRIJTJUI=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIaV-0001So-C8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:17:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C90E3F59;
 Fri, 24 Jul 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yQzSswFScmj62SxMmGeKfmLmVtIzb7p3u1YSeUWdEI=;
 b=KCKD2xIuRho/0iH9/kJcmhHZeLS+nIlQz/gGBgat2keiMXmPdG5nivXw23I8Zsj+X0asnT
 D5/UO15x44AgJpIpVY2X0xhPh8mhkwMUa9gh1sb6Mc6vAtIN/nJE6Z0qc7nC9JRbKVmMEW
 qulXs0P7EZUjTojnLK5v4xqrR9jKhgc=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=KCKD2xIu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yQzSswFScmj62SxMmGeKfmLmVtIzb7p3u1YSeUWdEI=;
 b=KCKD2xIuRho/0iH9/kJcmhHZeLS+nIlQz/gGBgat2keiMXmPdG5nivXw23I8Zsj+X0asnT
 D5/UO15x44AgJpIpVY2X0xhPh8mhkwMUa9gh1sb6Mc6vAtIN/nJE6Z0qc7nC9JRbKVmMEW
 qulXs0P7EZUjTojnLK5v4xqrR9jKhgc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F210B779C4;
 Fri, 24 Jul 2026 13:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4BERObZpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:42 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:18 +0200
Message-ID: <20260724133328.1837318-3-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7C90E3F59
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.com:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.com:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1wnIaV-0001So-C8
Subject: [f2fs-dev] [PATCH 02/12] common/encrypt: add btrfs to
 get_encryption_*nonce
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

Add the modes of getting the encryption nonces, either inode or extent,
to the various get_encryption_nonce functions. For now, no encrypt test
makes a file with more than one extent, so we can just grab the first
extent's nonce for the data nonce; when we write a bigger file test,
we'll need to change that.

v1:
 * adapt to the new on-disk format (btrfs-progs dump-tree changed).
   - use simple sed substitution to get the raw nonce

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/encrypt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index 8f664518..29293ea4 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -591,6 +591,16 @@ _get_encryption_file_nonce()
 				found = 0;
 			}'
 		;;
+	btrfs)
+		# Retrieve the fscrypt context for an inode as a hex string.
+		# btrfs prints these like:
+		#
+		#	item 21 key (258 FSCRYPT_INODE_CTX 0) itemoff 15081 itemsize 40
+		#		value: 020104000000000026845b8fc4d86191a06600879b25a852818ab722beec5fc403df968bf2e03af5
+		#
+		$BTRFS_UTIL_PROG inspect-internal dump-tree $device | \
+			sed -n "/key ($inode FSCRYPT_INODE_CTX 0)/{n;s/.*value: .*\([0-9a-f]\{32\}\)$/\1/p}"
+		;;
 	*)
 		_fail "_get_encryption_file_nonce() isn't implemented on $FSTYP"
 		;;
@@ -610,6 +620,16 @@ _get_encryption_data_nonce()
 	ext4|f2fs)
 		_get_encryption_file_nonce $device $inode
 		;;
+	btrfs)
+		# Retrieve the encryption IV of the first file extent in an inode as a hex
+		# string. btrfs prints the extent fscrypt context like:
+		#
+		#	item 22 key (258 FSCRYPT_CTX 0) itemoff 15047 itemsize 34
+		#		value: 010126845b8fc4d86191a06600879b25a852729c4e35b33e29d171a0c96b9eed33d9
+		#
+		$BTRFS_UTIL_PROG inspect-internal dump-tree $device | \
+			sed -n "/key ($inode FSCRYPT_CTX 0)/{n;s/.*value: .*\([0-9a-f]\{32\}\)$/\1/p}"
+		;;
 	*)
 		_fail "_get_encryption_data_nonce() isn't implemented on $FSTYP"
 		;;
@@ -632,6 +652,9 @@ _require_get_encryption_nonce_support()
 		# Otherwise the xattr is incorrectly parsed as v1.  But just let
 		# the test fail in that case, as it was an f2fs-tools bug...
 		;;
+	btrfs)
+		_require_command "$BTRFS_UTIL_PROG" btrfs
+		;;
 	*)
 		_notrun "_get_encryption_*nonce() isn't implemented on $FSTYP"
 		;;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
