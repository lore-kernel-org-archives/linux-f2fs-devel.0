Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661EBC531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3AYaHRpJQkmDZdkThM3YF8K9mSi8NnrQC19y99o4/xg=; b=f0vO9KmjhEvAi2OCikqqq/T+YP
	wehyTXtUgP6MAGseqji1KagQCZaFe2pOdoJZ/mzfcFg0wKdV+5I2DqvdGVG9bL3+x4OZ1hw2Hdhoj
	QuXG6WaCDULX3XxDTTx1eNXUAq0lbDJZHY9BP6EwIdxu3qI7lSj9jzU/+0zREs6fGUKI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnHuE-00012m-4Y;
	Fri, 24 Jul 2026 15:33:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnHtw-00011H-1P
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:33:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qs56XEJTOBFinoEPJP49pT6hCa6z1eMuZX0MvtQ+DGg=; b=ZFeJIoUsNCeZDeoGmT3Hl5q89p
 daXX2jQyVIXik34SrRNScq6kc1OKGNgCiSHRskap6oB+/ajbK9QWbNBK4IuKB0fusg3ERvloMsuKc
 YHcdn4NY7B/eluDyciM0ucx07vR9F9CxqywudROTYVhUpjB9dYJ4o5JQORvklSwa0Yj8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qs56XEJTOBFinoEPJP49pT6hCa6z1eMuZX0MvtQ+DGg=; b=dVpuDW/poKODr71SKtwdvH7tru
 zYKGcw0HSxlhSXHynUFfl44vZ4kNxuy8M7Pwd7ZhfIPf0hQtdjLuqHGEVdz2bsAvMF8Az9JYpLyuH
 DNsJQRPiAqgjBb9D8Y1NCLEGGRPVv2SxGS9JINul+ArWQy9qc76Sro1a0t1WnC+yCU+o=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnHtv-0007ew-A8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:33:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D2993F12;
 Fri, 24 Jul 2026 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qs56XEJTOBFinoEPJP49pT6hCa6z1eMuZX0MvtQ+DGg=;
 b=uXzeyrTjXjqOPX5SgXZ5LSAxY+DPs1cjMss1YG+DwfKQNPtQSsx6P3z6I5UbflAiswMUTV
 vVmfIbcsVYKG32bCViSG0Roo0AirTk7FWBSICVk7W/hiB5CYlpP1qsmPZxUCrc3fTX5gbd
 QtGEFHzMIWL1VHAW2ZNUhjlebF+2weo=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=uXzeyrTj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qs56XEJTOBFinoEPJP49pT6hCa6z1eMuZX0MvtQ+DGg=;
 b=uXzeyrTjXjqOPX5SgXZ5LSAxY+DPs1cjMss1YG+DwfKQNPtQSsx6P3z6I5UbflAiswMUTV
 vVmfIbcsVYKG32bCViSG0Roo0AirTk7FWBSICVk7W/hiB5CYlpP1qsmPZxUCrc3fTX5gbd
 QtGEFHzMIWL1VHAW2ZNUhjlebF+2weo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DF38779BA;
 Fri, 24 Jul 2026 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uCDyILdpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:43 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:19 +0200
Message-ID: <20260724133328.1837318-4-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 6D2993F12
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Headers-End: 1wnHtv-0007ew-A8
Subject: [f2fs-dev] [PATCH 03/12] common/encrypt: add btrfs to
 get_ciphertext_filename
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

Add the relevant call to get an encrypted filename from btrfs.

v1:
 * fix reading of the encrypted name
   - use simple sed substitutions and consume escapes using printf

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/encrypt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index 29293ea4..8a0aaf1a 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -713,6 +713,20 @@ _get_ciphertext_filename()
 				print STDERR "Invalid base64-encoded string!\n";
 			}'
 		;;
+	btrfs)
+		# Extract the filename from the inode_ref object, similar to:
+		#
+		#	item 20 key (258 INODE_REF 257) itemoff 15121 itemsize 26
+		#		index 2 namelen 16 name: v\354\301\231\214\341+\335A\002\216\3405eFz
+		#
+		$BTRFS_UTIL_PROG inspect-internal dump-tree $device | \
+			sed -n "/ key ($inode INODE_REF $dir_inode) / { n
+				s/.*name: //
+				s/%/%%/g
+				s/\\\\ / /g
+				p; q }" | tr -d \\n | \
+			xargs -0 printf
+		;;
 	*)
 		_fail "_get_ciphertext_filename() isn't implemented on $FSTYP"
 		;;
@@ -767,6 +781,9 @@ _require_get_ciphertext_filename_support()
 			_notrun "dump.f2fs (f2fs-tools) is too old; doesn't support showing unambiguous on-disk filenames"
 		fi
 		;;
+	btrfs)
+		_require_command "$BTRFS_UTIL_PROG" btrfs
+		;;
 	*)
 		_notrun "_get_ciphertext_filename() isn't implemented on $FSTYP"
 		;;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
