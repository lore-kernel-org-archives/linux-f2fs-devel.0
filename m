Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B586DC531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbG79krWvmBKgRYbB94MxyVfZYD/lP2AvRP0xKVFZk8=; b=clW5FeYs7vDEVf83sfrtjtZEvm
	Pl9ezWHlL7Yw21rbUKbGZsyRgg6R1NJAnj9KqouYU8JzQcFXe3k1/7Cx1Z8fQfK8qMI5vi1QHgdEK
	PzhAOqWnpzcJUtAaO2L+/Z1VA/0Pp+yG4rz8AGhgo/yGekWO3SZE+AK4kUZLig1Ly274=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnIDP-000757-Kq;
	Fri, 24 Jul 2026 15:53:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <neelx@suse.com>) id 1wnIDN-000750-UL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:53:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FCPBEO/DTcWGc2EV6pDMg3i2d+mYiLvgUXSYOcNfwsI=; b=mnw6S4eutNVvBxO3CP4Vj3tE77
 wkuGip6fubdF8jEjwaacENTpZPnbYM7GCiDNscPZy2PcFXvxsPqhQUvC6ii5sFjFxV+xOcxO3vg3/
 ecVoyvgTX3N6axTDVKk4l0OrpItCT1UgPVgSIkTJivDCXMF8GROa4KcbvA+bYfWpajZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FCPBEO/DTcWGc2EV6pDMg3i2d+mYiLvgUXSYOcNfwsI=; b=mOdRGShUUHWI5Qvkw6ZN2z151F
 Vi2lp9myTzcioQRKvTe7R9VeQjUBdySMa0lJhvXd7V0oa6qRbE3zw6E9YVuSqYl/lVPol+dMzUspK
 e9fmPr9VazxEOfK9Tc1yEEqYiDXFe5d3SKPTjEenwEZjP+95FGAkCvFsRukI7qpqqrpo=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIDN-0000FP-NL for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 15:53:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5CEAD7B843;
 Fri, 24 Jul 2026 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCPBEO/DTcWGc2EV6pDMg3i2d+mYiLvgUXSYOcNfwsI=;
 b=m2Js7+uyvuAWmT5bNMp63zSSf99fi2uFE31wbd0VPaNmiiRL0ObuxKDjew8ufiZNy4rOuE
 cB20sMqfby0MpSQHWilmaBrV9vOM7k/n2JBezKoXWKrRd8g4AAblpH1VdK8TUzH8O3ktPq
 jOI82jWwk7ccQdh9Yoo6qQOddTkOYc4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1784900029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCPBEO/DTcWGc2EV6pDMg3i2d+mYiLvgUXSYOcNfwsI=;
 b=m2Js7+uyvuAWmT5bNMp63zSSf99fi2uFE31wbd0VPaNmiiRL0ObuxKDjew8ufiZNy4rOuE
 cB20sMqfby0MpSQHWilmaBrV9vOM7k/n2JBezKoXWKrRd8g4AAblpH1VdK8TUzH8O3ktPq
 jOI82jWwk7ccQdh9Yoo6qQOddTkOYc4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45324779C3;
 Fri, 24 Jul 2026 13:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EFyDrxpY2pIJgAAD6G6ig
 (envelope-from <neelx@suse.com>); Fri, 24 Jul 2026 13:33:48 +0000
To: fstests@vger.kernel.org
Date: Fri, 24 Jul 2026 15:33:24 +0200
Message-ID: <20260724133328.1837318-9-neelx@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724133328.1837318-1-neelx@suse.com>
References: <20260724133328.1837318-1-neelx@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[12];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Headers-End: 1wnIDN-0000FP-NL
Subject: [f2fs-dev] [PATCH 08/12] fstests: properly test for v1 encryption
 policies in encrypt tests
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

With btrfs adding fscrypt support we're limiting the usage to plain
v2 policies only.  This means we need to update the _require's for
generic/593 that tests both v1 and v2 policies.  The other sort of
tests will be split into two tests in later patches.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 common/encrypt    | 2 ++
 tests/generic/593 | 1 +
 2 files changed, 3 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index 81c3d032..4c3fd904 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -68,6 +68,8 @@ _require_scratch_encryption()
 	# policy required by the test.
 	if [ $# -ne 0 ]; then
 		_require_encryption_policy_support $SCRATCH_MNT "$@"
+	else
+		_require_encryption_policy_support $SCRATCH_MNT -v 1
 	fi
 
 	_scratch_unmount
diff --git a/tests/generic/593 b/tests/generic/593
index 05f868f9..a80c28f2 100755
--- a/tests/generic/593
+++ b/tests/generic/593
@@ -15,6 +15,7 @@ _begin_fstest auto quick encrypt
 . ./common/filter
 . ./common/encrypt
 
+_require_scratch_encryption -v 1
 _require_scratch_encryption -v 2
 _require_command "$KEYCTL_PROG" keyctl
 
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
