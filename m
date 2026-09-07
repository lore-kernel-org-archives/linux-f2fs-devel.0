Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98221C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zicfmrOM7GXhyMQldnS5isHAlk1nqk0hI1NGLvAxAaY=; b=jmmV/28Be9WjyZ8alkmbzfen9Z
	l1C3yY3FbRoiL7/483NigBj/Stxnyftue7ErnvH+V7YM1zGepiZJMlp5iqD8T4lkY2WhuA9TF+xnj
	ZuGeHqv5pHt4CoMWGRxgL8/vQsayPzLEdWfK8iaIlbM2OtXyx1UCblkNIKocQDhJLs5M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3WLR-0003g3-VU;
	Mon, 07 Sep 2026 10:12:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3WLQ-0003fA-Mo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YYit+0M3Anf+oK4LLlIn10R8RMC5TUMRVTb/lweoMsw=; b=KaGnCxjk3BRYEK+VEMARahjKUZ
 dU+Uy75nYm+bAmt+Tq3Ih02KtWa6ZarziOw0wY6XQBJ+QJUL1qgdv8P7DT6qITtQjN0qBM/2CPYCk
 C3M+hImgdiBT8dsDg1/UdJtFRN9S7gL9GLFnr5vge/uO+mcs6rfFE9ytjN65w1efxPHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YYit+0M3Anf+oK4LLlIn10R8RMC5TUMRVTb/lweoMsw=; b=Z/uxySpbyS9Oi5Qs2I+KKEDOUU
 T7q813Qd7EagZDi6nd9kSHAGvF25YjIbT1TfxclMwQ0cZz3VWfLuLzdYfS9QE7qqEb+dnrOGg23be
 ZfTXYQxICcl19jbF1OAgWX7B2JVfUC97j5ad6tegsLOySqDrejx3Nwg1uloVUCj/3bK4=;
Received: from mail-pz2-f8.google.com ([74.125.228.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3WLN-00017e-Q5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:12:54 +0000
Received: by mail-pz2-f8.google.com with SMTP id
 41be03b00d2f7-cc1ccc32960so199304a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788775968; x=1789380768; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YYit+0M3Anf+oK4LLlIn10R8RMC5TUMRVTb/lweoMsw=;
 b=SjHDmNtghQLulu1NG/ygk8sy8SveSMM1BTzj3BOGzCfrd7CSDGOeYSFaDsJ8o64lf0
 U2KYt7Qw78jlp1GQ3xGflRcvoYo21HYrgYEGberA9f/rjKoEyqpCNuy0RtgQpPkRGbG+
 Whs5xqQHbLLIYc65vESHpTb4hv2Klqk040cJXsCLo3g1w7gtysPFBJrzlRawpYlPefe2
 E1Y9Z6bZzKAsRnP0ndhkYNx7+unrIWaHJ2EdnQf6p3D11DcY3oWeMayAFh2r10doa+f2
 KDLgKU5l3T7tM49Pwko2Ct2AKfG0wTPrgtrAlEBmm1FRxN7std+wUnLqfBW5SGFyseeQ
 s8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788775968; x=1789380768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YYit+0M3Anf+oK4LLlIn10R8RMC5TUMRVTb/lweoMsw=;
 b=GpYG+zAOFApKONlpvQfPj24IQUcajTT/jS7uYIA1jsfIpEcBiciNeSyWjFPJEK3ryH
 TBvKHBURAFibU55Ier79q+xSux+A5moUDRcdfeDwQTd2zjvNMtaMQCudzCxAxez88b59
 APVZPRHUWlBTqYQ6imedk31aatJOMIOMHQBPEYVUtkqwSUdl92xZBy5TA5d8wDIs6U2Y
 LQh1RzIJZsoGUAZOz4WnAje+V8ZbwqO+jSUF3qKvRk244zzBfHGz2IOSOdLsJVoSPlB8
 L83Ukg2z45+9vyBUuHemrUIUIhFGkUSg0zrKn/H/hK+cAssjsVXb/vOIzNgjTDY252kd
 NpDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp3RYcz9ogRXzdaVTejJ7JtThRkQwq1feyEROK4IKRNZ/Qq2DXHZDRD9OdoAVnR3SKZc/fgaXF/aZiZl30/kdV@lists.sourceforge.net
X-Gm-Message-State: AFuF++lFOrn2JjfJ8Cp2sAtFR2dPhdIYS11fz84PlWgzC84YkEKoABcX
 Me6EhXGw2p0aRX43tVRXH0+Zrv5R1p5CBUPx5NHU7DfkRoFrNT35LjMY
X-Gm-Gg: AYBFou2/u+78eQIMS+cQ4edIxvpap/vldvWe0vWDPmISVFMUDcairHgX/lLPWowfBwS
 zUdRe1SsRyNgKVWi2xSGyvGZ5gVUQLKOrf3HLtCx+g2AX3Dt20iG1/3ZVP/3RR1jFOIUptIRdWh
 4U4H0sIod4IuOjjjjYhAK5AWHa4dCBpxSFAGrwkl2VgbP/SZa2DFdsyGnVO2djx7T/jOsJH/WWb
 pRO1lI2uwJSCMkB0RTCZa8FLSnMLYgajfRLzmg9fn5atFTwnxrcbEnqz9aTu0sb+o2gneZAVari
 fWlXZU3xLSG8+8FdrVeL9WK0G3Ch4enK1iALV64ftX6HTtLTRjdxmRgq6o2hwVVE6EsM5YKtTvQ
 rPFhf2NJkiJ304kVasJqE58HUfxj2uuUsymfn2HF3BRrN5yNYU2shN4R8szR8AwIZiWVi0RDUYb
 yig95I7JK1E9L0rcqAtAbxVGoQWdgUOy3JC+j74+Qs+rmO5eo7kovG0n/DTMd/81BLbs3avSsAu
 H3pZmsy13z+ENBluiR1NJFbewUKFYODAUqG
X-Received: by 2002:a05:6a00:4408:b0:857:72f8:dca7 with SMTP id
 d2e1a72fcca58-8669b422078mr12409b3a.13.1788775967843; 
 Mon, 07 Sep 2026 03:12:47 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615273da5fsm4112935b3a.26.2026.09.07.03.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 03:12:46 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Mon,  7 Sep 2026 18:12:38 +0800
Message-ID: <20260907101238.2475724-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_yjqS5DDUxQdiqbQZLdXW-fQzHmVPHf32bdBhwth=kLOw@mail.gmail.com>
References: <CACOAw_yjqS5DDUxQdiqbQZLdXW-fQzHmVPHf32bdBhwth=kLOw@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3WLN-00017e-Q5
Subject: Re: [f2fs-dev] [PATCH 05/14] f2fs: support large folio writeback
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

On Thu, 27 Aug 2026 15:39:19 -0700, Daeho Jeong wrote:
> If f2fs_write_single_data_folio() fails on subpage 1, jumping
> to `out` unconditionally clears the dirty bitmap for the ENTIRE folio
> (0 to folio_size),
> and decrements the inode dirty pages.
>
> The unwritten dirty subpages lose their dirty tracking and will be
> discarded cleanly
> under memory pressure, causing silent data loss.
>
> Fix: Only clear dirty bits for successfully submitted subranges (`0,
> pos`), and redirty
> the folio if unwritten dirty subpages remain when an error occurs.

Thanks for the review. Agreed.
My change hunk may like this:

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
@@ f2fs_write_single_data_folio():
-static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
+static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
 					struct writeback_control *wbc,
 					enum iostat_type io_type,
-					u64 start, u64 end)
+					u64 *pos, u64 len)
 {
 	struct inode *inode = folio->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	bool atomic_commit = f2fs_is_atomic_file(inode) &&
 					folio_test_f2fs_atomic(folio);
 	struct inode *dn_inode = atomic_commit ?
 					F2FS_I(inode)->cow_inode : inode;
-	u64 pos = folio_pos(folio);
-	pgoff_t start_idx = (start - pos) >> PAGE_SHIFT;
-	pgoff_t end_idx = (end - 1 - pos) >> PAGE_SHIFT;
+	pgoff_t start_idx = (*pos - folio_pos(folio)) >> PAGE_SHIFT;
+	pgoff_t end_idx = (*pos + len - 1 - folio_pos(folio)) >> PAGE_SHIFT;
 	int local_submitted = 0;
 	int err = 0;
@@ IPU/OPU common write_done:
 		err = f2fs_inplace_write_data(&fio);
 		if (err) {
 			if (fscrypt_inode_uses_fs_layer_crypto(inode))
 				fscrypt_finalize_bounce_page(
 						&fio.encrypted_page);
 			goto rollback_no_dnode;
 		}

 		local_submitted++;
 		set_inode_flag(inode, FI_UPDATE_WRITE);
-		continue;
+		goto write_done;
 	}
 ...
 		f2fs_outplace_write_data(&dn, &fio);
 		local_submitted++;
 		set_inode_flag(inode, FI_APPEND_WRITE);
 		trace_f2fs_do_write_data_page(folio, OPU);
 		f2fs_put_dnode(&dn);
-		continue;
+		goto write_done;
+
+write_done:
+		*pos = (u64)(data_idx + 1) << PAGE_SHIFT;
+		continue;
@@ f2fs_write_cache_folios loop + out:
 		while ((r_len = ffs_find_dirty_range(folio, &pos, end_pos))) {
-			err = f2fs_write_single_data_folio(folio, &submitted,
-					wbc, io_type, pos, pos + r_len);
+			err = f2fs_write_single_data_folio(folio, &submitted,
+					wbc, io_type, &pos, r_len);
 			folio_submitted += submitted;
 			if (err)
 				goto out;

 			nwritten += submitted;
-			pos += r_len;
 		}
 ...
 out:
-		f2fs_ffs_clear_subrange_dirty(folio, 0, folio_size(folio));
-		inode_dec_dirty_pages(inode);
+		if (f2fs_ffs_clear_subrange_dirty(folio, 0,
+					(err ? pos : end_pos) - folio_pos))
+			folio_redirty_for_writepage(wbc, folio);
+		else
+			inode_dec_dirty_pages(inode);

Btw, I think the name f2fs_write_single_data_folio() is misleading now
that it writes a dirty subrange of a large folio; would
f2fs_write_folio_dirty_range() sound better?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
