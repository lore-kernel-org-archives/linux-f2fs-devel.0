Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BE9CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QrG1SD/ptRVpGBIjB+zhTU/B/bAkb2kM8hKrIsQO43o=; b=feNcY7lKvl3aSfskvlHHoGnNCK
	VmGKtlKw/s7LqKYXFCYNwKLgC/6CQqOjmCGmNnyzUyKVUtoZRMQKwmE5ewZY+UZ6ZKqC6jL8sf3vl
	B5NEkyMpEJlqKHH8aBwv3jJ27/b6gI8+7yoQceS210sYnU6Kufodwr4Gq+Wsm1bh94PU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1j9-0006Ay-RM;
	Wed, 14 Oct 2026 16:21:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xH1ij-00069Y-3E
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YM8vpXBXSpq5WxQcwP9CkEEf4JO8jt8VjOA9eQAmDyQ=; b=Q2nscrlXCAwn3XgFs0BkB4bfiy
 i6iXiJ+5J1Eo3lelxOB4cHMFRap8GWegJUGiH+igPfw/mhv/iOyeAikAJ+Vwbk+oYj4u5Ojrb9cYi
 b8zJxR2WXo7WOJQtBaoQT56DCgyPde66fz3bFJ640bgVVq1SwWuKElFG13TtimOmc22k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YM8vpXBXSpq5WxQcwP9CkEEf4JO8jt8VjOA9eQAmDyQ=; b=ikxE00g6s6KGxRFLj7agr7hSpF
 NrQ3SoAq7GzxwuXUuzHPNBoPPU4RZ6meM7RL7ZLAyhz+lsCTgSIi9WVYcLzUO6+uIQ+27lt4xJffn
 lz/FTXdg3Fp7RR6W62a7IMsg+Da4272ppYRQ59X4H0JUCEQFkTDiikgFcHgrxGY+1cdw=;
Received: from mail-pz2-f6.google.com ([74.125.228.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH1ih-0006gE-2N for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:20:49 +0000
Received: by mail-pz2-f6.google.com with SMTP id
 41be03b00d2f7-cc73514ac7dso1961908a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994841; x=1792599641; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YM8vpXBXSpq5WxQcwP9CkEEf4JO8jt8VjOA9eQAmDyQ=;
 b=BaliRixeOL0AkT0f8vzzXJyckKmvK2LfCcWFMicBRcw2V3B9xn3Y9drHYFwvk2GEze
 elMCR2DgyxdZj6cWU/HmwniITddbpna4nalEhVPQlTD6kDJ2kO/96uTNjGBWT3N3Ra4G
 19cB9RLPkYGPkvLS2q6VBp4pwg9Hhg4edUqAon4T3fYGNb6x+VRYWw1waci8PxaoHd8+
 jYN4TeUL5qZQmJaqWjD+anfyGiXyclLOoID8UmDif+/9ktBJ25ZXEkb2pmJPynmwBOHN
 Y4THR+ltNpFcsNmclcyKLK4E4RWEpjpUZlSKMpfhp7gNrAn8qugGNsR9iALOHKohYUO5
 BVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994841; x=1792599641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YM8vpXBXSpq5WxQcwP9CkEEf4JO8jt8VjOA9eQAmDyQ=;
 b=GtqeHChllQ4hgk6hNRSe7UuvmPLq5WIurPv+XudkzBTPMC5PHvu8Sj5WsAtkcREKjI
 9gwUlKy5Gi3/RzcCF/3xX6FGhMRpFhNUHvF9mTmjBnWejw976drAWAKtM/ae9BTr9gy6
 EIMEfsKFi7TUQGIobxGF1TbOl5Mcy5HsQ2u/Kb0MB+jxRD5PACTrSLNK+hyh8LIM+G+J
 3vtKZJNC2s7xLyAwVDzmkWwh8RnuamCx8KJpDD9H288LhMhcyjSAppjV7iPFVM1b3n7n
 1P6JCoI2naOoR6MAMFKIeaKtnSCouWoQ/Y+qp6oxV+idDUaiCKaQr0KcfgVnnx9m7+TF
 8leQ==
X-Gm-Message-State: AFq9FYJlVVos1O9yhyuEsT4omLvkbfZ4qWuemiU3ps2KnBiMNrMsoYzN
 SP80SDJvgpEBpRIvH3EuGTDebXieYIP36HyMOsAr51jFpwK0eTXofbmK7Uwkjl6ThcI=
X-Gm-Gg: AYBFou3v1TmchFgQ5LSdpZSYr35rKPP0Bt5Lo6fknN9u1NVaP9Uf5n+8QCh5qzgCJ2/
 X1HARafDvC4ZZssOcSgvIKmc8tvTl6fwhx4Vsb7SX3KvPPXLGf3hDPZZAi4svebgcqBTEMOTt+x
 CgO6KjFnT4b1BsoroFboUsmSRiDQfTwu0reNkXe6cfKhskvAwRRlx7poxPJH5/Ur62/Vi//H7g6
 NZeiz/uZEsg0xp99hnMiwq+UXHQI5Pa4xhNd0ZBVsYvs7wdL37TD/fXUwuUaMpVIVuyu9cp+xRn
 TvW3wsvFYZTT6xNFGdFnyZezuu7F/Goc6siYR1sJquuwSRYpTvjMG/souSvEONc2KbCKFW/34PL
 Zdd5Ca4VYLU5u9nUFEMCmiRKysnDtyqY8taga23w0fCI4g6YeSSt2SCtB9Y4245e/FAu3j/ERW4
 qqvEKX2iB8YPXyUMXKvL9nsWU/8+DkiQgCfxpYxogi1B52qUtGTPqYnroCxrAGq2wvUBOq4lxjo
 JY2qGkvwegfmE0cnkIamGhnCZrlsiGFjPtx
X-Received: by 2002:a05:6a00:1daa:b0:89d:c4fa:694f with SMTP id
 d2e1a72fcca58-89dc4fa7489mr2056655b3a.39.1791994841226; 
 Wed, 14 Oct 2026 09:20:41 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804d576esm1324612b3a.37.2026.10.14.09.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:20:38 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 00:20:34 +0800
Message-ID: <20261014162034.3834369-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xH1ih-0006gE-2N
Subject: Re: [f2fs-dev] [PATCH v5 10/16] f2fs: support partial uptodate
 large folio read
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko says:
> Because the batch size (len_blks) is based on the mapped extent length and is not
> clamped at device boundaries or fscrypt limits, could this cause IO errors or silent data
> corruption?

Changes:
@@ -3117,15 +3134,28 @@ static void f2fs_skip_fully_uptodate_front(struct folio *folio,
 	*max_nr_pages -= skipped;
 }
 
-static void f2fs_truncate_read_extent(struct folio *folio, pgoff_t offset,
-				     unsigned int *len_blks)
+static void f2fs_truncate_read_extent(struct inode *inode, struct folio *folio,
+				      pgoff_t offset, block_t block_nr,
+				      unsigned int *len_blks)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_folio_state *ffs;
 	unsigned int next, end;
 
 	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
 		return;
 
+	if (f2fs_is_multi_device(sbi)) {
+		int bidx = f2fs_target_device_index(sbi, block_nr);
+
+		*len_blks = min_t(unsigned int, *len_blks,
+				  FDEV(bidx).end_blk + 1 - block_nr);
+	}
+	*len_blks = min_t(unsigned int, *len_blks,
+			  (unsigned int)fscrypt_limit_io_blocks(inode,
+							folio->index + offset,
+							*len_blks));
+
 	ffs = (struct f2fs_folio_state *)folio->private;
 	end = offset + *len_blks - 1;
 	next = ffs_next_uptodate_subpage(ffs, offset + 1, end);

v5 clamps batch `len_blks` to device boundaries and `fscrypt_limit_io_blocks()` to avoid DUN discontinuities.

Sashiko says:
> f2fs_ffs_find_or_alloc() can return NULL on allocation failure, which is immediately
> dereferenced by spin_lock_irq() because there is no NULL check.

Changes:
@@ -3235,6 +3266,10 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			}
 			if (folio_test_large(folio)) {
 				ffs = f2fs_ffs_find_or_alloc(folio);
+				if (!ffs) {
+					ret = -ENOMEM;
+					goto err_out;
+				}
 				spin_lock_irq(&ffs->state_lock);
 				__ffs_mark_subrange_uptodate(folio, ffs,
 						page_offset, PAGE_SIZE);

The hole-handling branch missed to handle -ENOMEM for f2fs_ffs_find_or_alloc,
v5 fixes this.

Sashiko: https://sashiko.dev/#/patchset/20261013115621.968742-1-nzzhao.sigma%40gmail.com

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
