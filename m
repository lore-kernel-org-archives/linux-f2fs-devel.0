Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384FFC79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icPJmcDVZkQdgJfKLdf0xdaRkSSh3o4euHuwMXlee+I=; b=Fz2adDU5oPhYiUudabkwO/P7j/
	kXBeEFEn9ku0LGFti72NI76rqm7/bwo2N1x4YZxTn2NFehNwu6/dsgn1gnBG4YSG4ORxLQ0jNqRve
	Wvq9/C+DmUUv2O7W0yG3d9tehwzd8r5udN/IYObTZolsKwPXAqPNEIPWxnjI2PByvoJE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3W7F-0001Zt-Lw;
	Mon, 07 Sep 2026 09:58:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3W7F-0001Zn-1s
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IAp4ART9Vww7RNr3R7LHs7YtaKcM1bWQu00EHChcxAI=; b=g6J7cNg/xFdwRKLMJ69oMJSiwe
 D/qCCGu0UJmxr7nnncBW73ev0p1rIUzxU02ywBhEX1+V+/tBt4qqyL5UGfGRpxKAe/sADVMIXmX02
 7mz2wEYSWu1iP2VG1ud6xkroCE5cbKOMrhKcK+wZF4E/jfMtYUkMtYag/NmjmJvUNkM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IAp4ART9Vww7RNr3R7LHs7YtaKcM1bWQu00EHChcxAI=; b=jOXO5aPiHFXD8QT45rcyyZSf6J
 EDXnA7lL/bb6lnAzSOyYEvORAwOerbefWA6od+txeVYxnQZR/yQQHA9IPT92J2GeDzH5Ltz6wqF41
 CP2yHi1CD/VcwJ5qDm+z+IgyqooVJriM8cyh6Xg6AVTPOO9QNDGWWzyjSA4ghskkEHec=;
Received: from mail-pz2-f2.google.com ([74.125.228.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3W7B-0000q3-8c for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:58:14 +0000
Received: by mail-pz2-f2.google.com with SMTP id
 41be03b00d2f7-cc1bf4744e6so1640716a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788775087; x=1789379887; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAp4ART9Vww7RNr3R7LHs7YtaKcM1bWQu00EHChcxAI=;
 b=V0LOjm0IeRm/5DptJbARx0Pu7MC8DQUBh1UK+TmqXLZeig1SiMGfvzi97DceL33j5F
 3PUufiRlI1gMAwMLg0Hg32vyvq2FGbLOmuDd5drDDkqFFLIzb5DJdWMpYu2VwVKNqF2R
 biZTItxlvvyCy3sAmQSKtgOvw5H/W6md/y+22tM/pud6ISDpjGO6eamjA0IcyifFfNaz
 lxUR+/yGnKqlW7EqMxi0RB7EHmCY35CWeLuKBvRYC0rzMDfKx5/GBjnQQu87TdJIMmko
 9Hj2s/KgNvaMFUK1LSgVFjbPY9l4xG2pR2Qq6ktw1H5xejCfsP8HOxxGEuIghzM6sFej
 faWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788775087; x=1789379887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAp4ART9Vww7RNr3R7LHs7YtaKcM1bWQu00EHChcxAI=;
 b=Xca/ORzzCK4yrLkkulO5zSEIRfhYWf+6fsm9KTDolP+PgbZkPsWfgztZf7zNcbfLSk
 ZusMwt5lWN4iXypC1qNgBhsbNsvuhMQ9JOogiE+yDBfdN02Xz2reVhDHzhQ2h/GKIbSB
 C0E7JxZVhv+4pnef1sTDMOMVqVvCmMmu4nwqrfM2OiuABSHaaWiW8SiLRMN7t+UYQ2A8
 6Oo2NxvxplKKQdhjrvZDjRFskjaJuLECX1+62aPhYL9V6Vi1cMGZsU6rQ46Cv8oyBWc8
 ldKiNt2GE52nWQZa+EfCnD0wmvy5fYcxpRqNz+xNv+dE2wIkMLHvmKcd/1+Ql5uH7vK5
 pIbw==
X-Gm-Message-State: AFuF++kT9wBc0Ma7oG3gTfKoIhl9i+YUaCriSAyshFHwJ4+z3GCp2XWA
 2fi6r/AJlvLmfLT+A/apgdWz8OkWEhJ77N6q0gWMd7ISy3yC+aJDfJwo
X-Gm-Gg: AYBFou0k5y/RbqNLpT1tVJWo5VJ4Ho+/n30FKYV0cem2mGdltOpZ42mPKCmPcWBqJJX
 ghEtFD+90lQG0fPne3EawSnW9ux0E0Dc8iTODcOubV+8dvVKNJXu6TRuxZELmX9edvAipaPk85a
 dmrg9g6gj8W36g+d5YzllxcX9smZWWcUy+PVpe/TZEjnynEKUcEScV+ToMH8G8N4xXq2w/NuNwA
 L9Rk69akkuQotsfxHHYi2qaMAiNQExWYJdTdqsmOfX+Ay8P/MfkLRIjqDx+rkXJcBdhw9b5bl43
 tBCdKHiwOHGsyVaDW4X0ZjkN6au1H+vIucLCAsIJdIHjIeMW80tRs5i/Ltsf0jGB8dYEmFyUyPO
 xgruaPFWbhymAd0ApzTru3+GXkNEXAwrFLRBqEvPSNYRIMHKKCj353GJWppuB7rkBWC+UO3EesZ
 vGZ0Hjko/RdAni06XyuqINHDPuB/7slgnUPjF7Oj2T7H0cfyEqxrDekDdQUK9FuxuQ1DkMms9sj
 Jd69OxFMIkOuzvQ/saOOYrbSA==
X-Received: by 2002:a05:6a00:2c97:b0:857:7337:5db9 with SMTP id
 d2e1a72fcca58-8616af6486fmr28939025b3a.23.1788775087454; 
 Mon, 07 Sep 2026 02:58:07 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152d32addsm4065080b3a.34.2026.09.07.02.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:58:07 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 17:57:59 +0800
Message-ID: <20260907095759.2461366-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1ffd3a5-9fdc-4f26-bd9d-5f55e563f800@kernel.org>
References: <f1ffd3a5-9fdc-4f26-bd9d-5f55e563f800@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3W7B-0000q3-8c
Subject: Re: [f2fs-dev] [PATCH 12/14] f2fs: handle block cloning within the
 same large folio
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, 31 Aug 2026 16:19:05 +0800, Chao Yu wrote:
> A lot of codes are redundant, can we add fdst = fsrc;
> So that we can replace fsrc w/ fdst, and clean up the redundant codes
> below:
> Thanks,

Thanks for the review. I'll restructure the else branch as suggested:

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -56,25 +56,66 @@
 			f2fs_put_dnode(&dn);
 		} else {
 			struct folio *fsrc, *fdst;
+			size_t src_off, dst_off;
+			bool same_folio;
 
 			fsrc = f2fs_get_lock_data_folio(src_inode,
 							src + i, true);
 			if (IS_ERR(fsrc))
 				return PTR_ERR(fsrc);
-			fdst = f2fs_get_new_data_folio(dst_inode, NULL, dst + i,
-								true);
-			if (IS_ERR(fdst)) {
-				f2fs_folio_put(fsrc, true);
-				return PTR_ERR(fdst);
+
+			src_off = offset_in_folio(fsrc,
+						(loff_t)(src + i) << PAGE_SHIFT);
+
+			/*
+			 * For same-inode operations (collapse/insert), src and
+			 * dst may fall within the same large folio.  Detect this
+			 * to avoid self-deadlock on folio lock: in that case the
+			 * destination folio is fsrc itself and only its block
+			 * needs reservation.
+			 */
+			same_folio = src_inode == dst_inode &&
+					folio_contains(fsrc, dst + i);
+			if (same_folio) {
+				struct dnode_of_data dn;
+
+				/* Reserve block for dst before copying */
+				set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
+				ret = f2fs_reserve_block(&dn, dst + i);
+				if (ret) {
+					f2fs_folio_put(fsrc, true);
+					return ret;
+				}
+				fdst = fsrc;
+			} else {
+				fdst = f2fs_get_new_data_folio(dst_inode, NULL,
+							      dst + i, true);
+				if (IS_ERR(fdst)) {
+					f2fs_folio_put(fsrc, true);
+					return PTR_ERR(fdst);
+				}
 			}
 
+			dst_off = offset_in_folio(fdst,
+					(loff_t)(dst + i) << PAGE_SHIFT);
 			f2fs_folio_wait_writeback(fdst, DATA, true, true);
-
-			memcpy_folio(fdst, 0, fsrc, 0, PAGE_SIZE);
+			memcpy_folio(fdst, dst_off, fsrc, src_off, PAGE_SIZE);
+			if (folio_test_large(fdst)) {
+				f2fs_ffs_find_or_alloc(fdst);
+				f2fs_ffs_mark_subrange_uptodate(fdst,
+							dst_off, PAGE_SIZE);
+				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
+							    PAGE_SIZE);
+			}
 			folio_mark_dirty(fdst);
+			if (same_folio && i_size_read(dst_inode) <
+			    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
+				f2fs_i_size_write(dst_inode,
+					((loff_t)(dst + i + 1) << PAGE_SHIFT));
 			folio_set_f2fs_gcing(fdst);
 			f2fs_folio_put(fdst, true);
-			f2fs_folio_put(fsrc, true);
+			if (!same_folio)
+				f2fs_folio_put(fsrc, true);
 
 			ret = f2fs_truncate_hole(src_inode,
 						src + i, src + i + 1);

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
