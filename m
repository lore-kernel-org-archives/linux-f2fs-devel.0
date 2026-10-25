Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4CE606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U+qiVMuT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZkZ4LYBK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kHXxIzEz;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F30liOVR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=3dW8SeP9/c3lYZ16v1A53Jrz/MAQgSmNmX4Wrqe9uUo=; b=U+qiVMuTYZkLOzDrqA9AQ8tcYM
	qlJ2mAg3TFCs67V64e3cDNcBQn1KSQtY1ub/H7MM+zF9bNnrJ8H4fvE7hpM1Q5ZXU6Bh5zxX6Pndh
	wPnDy0Gu2rRM4Bc6oMjoaKVdvih1zsaUIdcmhAQOHGqhZDxGaudCTGgwriw9bjM+1GiM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xL2YG-000000004uk-0QA7;
	Sun, 25 Oct 2026 18:02:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xL2YE-000000004uZ-3JSW
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rgV7roqEK0hJNAZ4WkNhuBhtFoAn+fipk0Qu5uolb/o=; b=ZkZ4LYBKx8f9wv61J3ZeO6zINo
 8Lsp0wQHIMlNBHspvjcAW6WdCrG0EMbLF8LWqM9By5a8EpOP04Y0UvqqK/j1HwjKz42mCgiYV3hw3
 f/COra5GqADpoFubGmgxN7Zn2b6pi63JDNFaz+GXbeZHH+2VLkfQLdrAEI6NJf2rTCFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rgV7roqEK0hJNAZ4WkNhuBhtFoAn+fipk0Qu5uolb/o=; b=kHXxIzEzNHn3rfX+1Xxjz47oeM
 oXj0QwAOqV2lVscdsMAejdfgo+Z1rL9BqGy1y/EgTDHYqREovWC9xj4eSEOzjHlb6UhsemmHYbWsW
 s2ncVWPNixM7XwX1nVDpUnlSrAZAQj1nW0twL0dqYYeFSYCJNn9UCQiGn0zIVydXJgxA=;
Received: from mail-dl1-f44.google.com ([74.125.82.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL2YE-000000001WW-1izb
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:34 +0000
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-14fd9dafb0dso2194746c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792951349; x=1793556149; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgV7roqEK0hJNAZ4WkNhuBhtFoAn+fipk0Qu5uolb/o=;
 b=F30liOVRgU51w3gXlqyfIQT53cFSWZPXRvDiVk1Vqhwa3HS2rtzsT0ooJ4XvAVLGby
 zoH5c3KRdBwLrXIiQbuvh7YOBM+aTEDnLQ3rw4NnbSm3MbMjOUaNPqdJR6uy07xzhf9e
 PFgTpRX46ePRdns5RZGotCt57+aTPfGra6hiDcYFWKy7ohFfs90SXjmiGNrxC1KGylhA
 vqmvpabvXhz3N2w3u9amhBQ9i4aLJ46Wbx8nxwMWovH5RIVTORqx21VM2NTz/4Bqwezp
 diCntdAsT61Xfik6HquhwqYwV133MI3OSAb17oOYFqSEQ5UyA28vqGB+9m81jcoWtIsG
 aewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792951349; x=1793556149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rgV7roqEK0hJNAZ4WkNhuBhtFoAn+fipk0Qu5uolb/o=;
 b=po7sw34Rt9o0F6Bb6/0O4O95WccgVOItQWOc6ESyvHlTrtdJrkGcuj/rxNbUBeWXWi
 Kwc6IOqeQ4+IAo5MQPnD9EFWVJzFb/OCTiIihGIiehXnyPS7gQ1kizrT4G5ij3yGaCo4
 c2bBP0WtPGPZdRz2mtCzcd1wFOkeLbDQcSC/HDFzpNuJ4IVj2TUF9ppPDl/18RzPiXH+
 kVxM+Sgjje+UCLZi35Edo1KyBuQqel4E0vCFUI1eK5mRtVFdCoxqgqqzPz9TOXgn18gv
 9OcjinBV0sB1Nr/fftfbGt8zG6Hnrgty1N52ki3JJ7HkexevLeo/8lWhbMPhwaplpW7S
 sbjw==
X-Gm-Message-State: AFq9FYLtF4z/5G94mCqpdv6bu8BghNG8MuOKFGmcyuT6o5I8TTJ+XZ1i
 KUf6fKWdhe1ifQX1MjkoaJY3z4CBeTzvR6vrAF6545BHw48iB55h+Wve/XalkAfNaxM=
X-Gm-Gg: AYBFou2LA3vxd+l2ksG2mRyw2cpYAZ0H+YN3OWyP3U+MpWHAD2ZEKV8C5UvyY+opJIX
 oTZhYCvXNizkK7XJMZD/1hDgcj+YD+lTFBrhAYTlXqFTucwA1xdSUtI+Oh6a42P65oU+nxIlHbX
 35qeCSqV/CsvTstTTt0JvdfpMkVPCoK5Pa7xKMgFQfwGFHgCqI6FpuMn6F8GPkIv7MnN2wFHP2I
 z1wrc1YMU3NNBhBjx5t/ODnSciZ+6r/Q/Tdh4iZWRLGiZ+ecab6RBrw1ZKstpAnCWBIRnndJCby
 OSqO8V+pdR3DFq3GGuyEW8Uf5jF3qZxPdA6U5vai4MXq8C9keJZgKXsjny1yjIoN9wFCIP7m+5w
 MlQlvTLcVmrzum/1aVukEzrNRoDFz1imNqY0/wmyD1j3pwEJyaCBzYEL62xJd0AtIFTEiPKx+gP
 d1dpny6U/YeXYdKTroQVssdJUHfZ1ioUlkWSWWsdZjRYdT+eDhvzqdbtddLpF/yoZ+HAEk6vRyx
 iEei3zfR1dCt0RkkLUzC2ymJ6C8DxUXw7BGmx31ePLWwC8HVsiF+kmchHljOaq/KROxhyI7GzYw
 0UO0sT4ECVqxMQsO/2c=
X-Received: by 2002:a05:701b:2405:b0:18c:e014:6f1d with SMTP id
 a92af1059eb24-19929a9e465mr6481076c88.1.1792951348538; 
 Sun, 25 Oct 2026 11:02:28 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5a515sm16099227c88.19.2026.10.25.11.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:02:28 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sun, 25 Oct 2026 11:02:07 -0700
Message-Id: <20261025180207.348498-4-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025180207.348498-1-teel4res@gmail.com>
References: <20261025180207.348498-1-teel4res@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xL2YE-000000001WW-1izb
Subject: [f2fs-dev] [PATCH 3/3] f2fs: refresh superblock CRC after MAIN_AREA
 alignment fix
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Cheng Yongkang <teel4res@gmail.com>, linux-kernel@vger.kernel.org,
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

The stale-CRC trigger was reproduced 3/3 times; with this fix both
superblock copies end with segment_count=9 and a matching CRC, and the
next mount no longer reports an invalid checksum.

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
