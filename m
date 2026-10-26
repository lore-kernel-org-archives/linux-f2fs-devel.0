Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068F606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ixLrYDc+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gLh9d/kA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ixPsrFlO;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VZjJ+1rN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=3UqC+casrK6a2kGiPu2694r12z4H45aqDCw4GhGFFZ0=; b=ixLrYDc+RdeZbO3xzJ8uCCiXzf
	fZ4Ruy6+dI1nyM63scODjtR9rd1CYhNfnAA/Gz+GMHqtvaq6vGMssAewcpUn3lE8Appx0WQHjpksC
	B1Ay9k6t0N2w3b6vim3sru0qUe6xcKaJd2DPQvbhG7LuWSyx3ULp+lSYsQKuc5Hzk4KU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLIIH-000000001Ny-3YPD;
	Mon, 26 Oct 2026 10:51:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xLIIG-000000001Nr-2CmQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=; b=gLh9d/kAtZZEC08HxKb0bDc+Rs
 wpBfuzxYJrqChKb88R6NPXoxThXxfMMgD3tWyzvW0e7lYLRy0QzQHREgEc0Z2Sj4Q6CKjrp3latH1
 5Uc7UT7KVNQuVCPzcmFXWqHsQIdtdRqC++yhZ01lmOarAJNjwESyw0IR4m9gfvPZKG/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=; b=ixPsrFlOQ8LQ4vVZcMZLSNCB5X
 YUqTbKjaSH6ovYhvH/X1t89nC52iGFLjNAEszr9LpY9iVONCInEdBivJpcw82mw+fUwDDNxpLHUks
 rHDYiWI+hs7LguQQz+MvBkxXj0eYQeaNDDl66pezc0gAfii06mGWJEB1jQH6F/89ekW4=;
Received: from mail-dl1-f49.google.com ([74.125.82.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIIF-000000004W7-3TO9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:51:08 +0000
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so4857554c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793011862; x=1793616662; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=;
 b=VZjJ+1rNc4ZJxWiKuaZXVdhYFloOA8QsaRYi9Ua2+ysjx6pTyE41HLzsdSkGTVodeR
 XNRDr+9/NfRELhO4fHAu5DfLNnoLZXq5gluKe81Vc8vG/54AwuRdbJtBdXN3ra/gLpq6
 VAOPjXAj733tbc555hc5XOSmY80xm8UI2ONhoBm7yUb70mSGzTwOlLlorf/pDFRlyK8T
 Zkpe03hn3fQGaOdwGgb6BmgNpNJG/CEK9kzMaxtN9ixHwjmWu8ABQNjMepOHXIjgvnbG
 MQxNhCUrpmIn889k6LRpD5Nrxa7YHKaSaVhUGD64aTJ1E5ygk2jdJ8xE+FtkPzMOvWGL
 LirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793011862; x=1793616662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzSTm2Fji8eE3olX3VmRZngbwlC7i6ctxbW2rBhW5I4=;
 b=Qq8yChzck+4+YgzxYGKZnje1zOu0T4R0uvYJVUnKDWgw7f/LvyMD02jD2wrioyT9AO
 7dhhTRtT8TP4THN/93VDWULWloyZztWLUaD8WKEaheApocY1Q5H7EIQbeS/Qv4/riO5B
 YV2gW/+/upDx1pv8HCQFtnfSBE9hL9+l4UjZik5L6Iee7oVWmxl2TAoBlqBwRahmoBWQ
 kBvnmHi2TC3wege200s6ADB4L/ji6vZxYG5KLgOCKN4SBlNeDOuynDfxEqEqOv6XfptF
 F5/g34S98OQJ9XBkqiw5de70uCnol31w/44Eg+LM6EYB6qZ4uydI9B4R+ZZBQaO99BLp
 D0cA==
X-Gm-Message-State: AFq9FYKJzZkeuDTFjczW/PaHTtVr+OmhL6aj3Frg7RGMwMjeuDqmQe4P
 bGotUgpTCuhZguxxeF9KaErq5mGI1yxC3FaZkPc9XNX1bAkHMYNjRZhI
X-Gm-Gg: AYBFou0KgArCaqKJK6jEjrOPUlXpct8wzWpQ20EvQd/Su+XK+h8nnlKI4nJjuFV+Kch
 cMMDUiKHJLf+izsTFr4Hu+ZnDbKaZ/youxijbHBqGFz1qStWWyrjovysWIOi0fnSYB0a867LVLQ
 g1V5c+bn893XZxLirYe/ErHHXSMJ7A1MSc5iItPKppItMjgzlVwLvv+ykJ9KEjhrRHCb4ngWemS
 EWZKYmOSmgo2upSgvopHrsG5Pt0T7HG7zhgypTSN3iBVLdscukze5lchI+cQ0gtU0zefH5gL0Lv
 ShBNy5n/YN+6eDaWAjV1fd/TPQNEkPweLr7V7JE0qeBdv3zw4Lp4ieiBe7eNr7bCqHurOj8QumN
 E6PmyWVQ1rXeYdATDdwixbE0zMrEFleZJs54Ol/tfO5fOYDAGyFM1d26++ajCRzG+jk7Tp0jspw
 WywUmNqmn+vOBQhY/Pu3F0q6Vn31C4dmIOFt4FoECWPH1Mf2UQ8ImY2viHDm2ng1zCgutrJgLoz
 Rf1qWfJ1OpY816XXoo6Mc/0sTIIHjZTBSCZIJ+xgBQfSUtPnEtJGp00fsAtKiGiIrGfOoIRj7AO
 6O1i0lsmhRw7PDMh+4yad73SAqyZu+iWKCNIpkeF
X-Received: by 2002:a05:701b:208a:b0:13b:3132:6e99 with SMTP id
 a92af1059eb24-19934a96a8bmr9053500c88.20.1793011861911; 
 Mon, 26 Oct 2026 03:51:01 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a020df20sm27897863c88.6.2026.10.26.03.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:51:01 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 03:50:41 -0700
Message-Id: <20261026105042.1148554-4-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026105042.1148554-1-teel4res@gmail.com>
References: <20261026105042.1148554-1-teel4res@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLIIF-000000004W7-3TO9
Subject: [f2fs-dev] [PATCH v3 3/3] f2fs: refresh superblock CRC after
 MAIN_AREA alignment fix
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sanity_check_area_boundary() fixes the on-disk segment_count through
__f2fs_commit_super(..., false), which does not refresh the superblock
checksum.  segment_count is covered by the checksum, so the next mount
fails with -EFSCORRUPTED after the alignment fix.

Recompute the CRC over the modified superblock before writing it.  Use the
raw superblock's feature bit: sanity_check_area_boundary() runs from
read_raw_super_block(), before sbi->raw_super is assigned.

Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b90831e..7dcf15e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4023,6 +4023,13 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
 				segment0_blkaddr) >> log_blocks_per_seg);
 
+		if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_SB_CHKSUM)) {
+			u32 crc;
+
+			crc = f2fs_crc32(raw_super, offsetof(struct f2fs_super_block, crc));
+			raw_super->crc = cpu_to_le32(crc);
+		}
+
 		if (f2fs_readonly(sb) || f2fs_hw_is_readonly(sbi)) {
 			set_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 			res = "internally";
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
