Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C42C531FA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a0yMc5o2K/NI56484XfUoYg67z8Ib5DsMuaKIfJtTo4=; b=Sb/uhL02oBLX0kqRG0NUdFabgo
	wytEE/wVv5IzNaUHBchACp5KFynjR6v5c4Y9V6TqbhvpywYswgyaYwzsFf+nPa4eHFOsGTusZGF8K
	YRE7MMjYyGyjP6SXIeoelOr8TUPnoxhH8V/fO/ky+eF8oetErLgIBsiFQ6AkVR1QmS4A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIae-0003CK-G0;
	Fri, 24 Jul 2026 16:17:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnIac-0003CD-V6
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:17:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uFahWESja0mcpWXiOKBmdg7IRuLRaxK3qV1RSCqu2dY=; b=fBBDD/QWFJg1Q5zcEjG/UlipgC
 OxlWd94tmWzfLFe9W1klgvd8nuuQl4WF61xFheEXVAxq3k0VLS9aZspro7MY0g+/sp/8t3K0IBDcx
 Z11X7wUEZv0Ah6L9WDQdM51lH7AgmZ8hz058GYKjYSs4GF7OWPo9gcQ0+x7A+gt+LeJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uFahWESja0mcpWXiOKBmdg7IRuLRaxK3qV1RSCqu2dY=; b=LDw8mZ7qz1OIvqvvk56UQ/xVLI
 ZMsRUSLzn0igtQbMLz0Mm0mmTUJP+Uum3VBk8G/jdHvLBUvvbGxKxwJrh6TO5OLryN8XD6bFv/Pis
 jaerKVumRiKJuRnYTuZyRAAB9Kqp0K8jTntm3hm+zTmylRtq82d2Qa8CJWBzrxs8pLHo=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIab-0001Sw-83 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:17:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CB917B84A;
 Fri, 24 Jul 2026 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFahWESja0mcpWXiOKBmdg7IRuLRaxK3qV1RSCqu2dY=;
 b=X2mqGnkx7k2FxyrOeNhb77LGUOYApliIQa7Pf6TBjHGHSLaorCH7tQBzEr+m6e6HfANeez
 5xOW7C3oa9N1al3dMDJ6oplJxW2d2OM532Ity6Ocs019kpS3zz1vdCcR7GqBQsh1LofOsQ
 sq9C9mFpN+vI5tmiO5OpM5XqZHun+Sw=
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=X2mqGnkx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFahWESja0mcpWXiOKBmdg7IRuLRaxK3qV1RSCqu2dY=;
 b=X2mqGnkx7k2FxyrOeNhb77LGUOYApliIQa7Pf6TBjHGHSLaorCH7tQBzEr+m6e6HfANeez
 5xOW7C3oa9N1al3dMDJ6oplJxW2d2OM532Ity6Ocs019kpS3zz1vdCcR7GqBQsh1LofOsQ
 sq9C9mFpN+vI5tmiO5OpM5XqZHun+Sw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D34D5779BA;
 Fri, 24 Jul 2026 13:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MGjrMLlpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:45 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:21 +0200
Message-ID: <20260724133328.1837318-6-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5CB917B84A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 R_RATELIMIT(0.00)[to_ip_from(RL8xi6x1pj1uf48mqopq9zr7qb)];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:mid, suse.com:email, suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1wnIab-0001Sw-83
Subject: [f2fs-dev] [PATCH 05/12] common/verity: explicitly don't allow
 btrfs encryption
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

Currently btrfs encryption doesn't support verity, but it is planned to
one day. To be explicit about the lack of support, add a custom error
message to the combination.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/verity | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/verity b/common/verity
index 11e839d2..a857619f 100644
--- a/common/verity
+++ b/common/verity
@@ -224,6 +224,10 @@ _scratch_mkfs_encrypted_verity()
 		# features with -O.  Instead -O must be supplied multiple times.
 		_scratch_mkfs -O encrypt -O verity
 		;;
+	btrfs)
+		# currently verity + encryption is not supported
+		_notrun "btrfs doesn't currently support verity + encryption"
+		;;
 	*)
 		_notrun "$FSTYP not supported in _scratch_mkfs_encrypted_verity"
 		;;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
