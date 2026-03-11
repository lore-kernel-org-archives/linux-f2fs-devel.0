Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0747E1049524
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2026 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjDLgg2UVjGQH0CCvX4mMxPGF4DSUtjdlCfgiKegquI=; b=T/Hn8JECPqYwNX+mD37n/ykfaK
	8LfwAekmo8F2Y6gdFQKkuRo50ptUu+IvNmrZZKrusrBJE/GybVUsfDQeRWvK/6E2sYccBQA9VjtQG
	tim3AQSfZrvL+z9dDX38zRkPml92tGWK+neEmX1BJvFP88gH+rpeSa9WWuWTLcKOAt+k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0GKF-0003i2-Pj;
	Wed, 11 Mar 2026 09:58:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wangqing7171@gmail.com>) id 1w0GKE-0003hs-ST
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 09:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iOemOY3GRBon+h/gNtOxQ4VEEGmdm3FWxbjJem+FfZM=; b=Y42d+IiErgasFfoqsM+yP8Cee6
 KvtBJMnL4bgCo+maY2yoGgg8+zBpTExl86btYmYSy1ZaTY37C9AZUVMlkuU86kaRiAzXKG56CNOXi
 ARs6DhSrqMizSPRi9yYkMtTnbwC69wlE1UYe5gmVJ1YSE95g8KsIXOarHnKbDH39nECQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iOemOY3GRBon+h/gNtOxQ4VEEGmdm3FWxbjJem+FfZM=; b=AiaBqsJ9MIXZe6Klbd6tqu70f6
 1Oob3Y8Tsjw51+dd2qu8DAEyLAKaM8+9s0wj0JX7Ckc6LqH8EWtq6I43L/xuP3sw50sEfZFCjNdoq
 fkYH9iq7d6jm2Dn3JL1g1w4DDULfsaXG+dkEr8MAkRTubp+bPc5k+M43Kz8B9IxY2UN8=;
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w0GKF-0002dO-BA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 09:57:59 +0000
Received: by mail-pf1-f195.google.com with SMTP id
 d2e1a72fcca58-82735a41920so5151222b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Mar 2026 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773223069; x=1773827869; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOemOY3GRBon+h/gNtOxQ4VEEGmdm3FWxbjJem+FfZM=;
 b=lazQdfJASPxDNNw5p4t5D4qJS5/JgKuDLFlSh4I/hDlODZIZzanFYsAQJjUfiIltL7
 UvPN++vK9dO6jDNbNYG3HG/qUDxuGvr3+UP84ab/qBYCZrJmFIjn8lNTqve++RKfJ6vN
 3nVWm3etA+9iy8RPaclDf3hd/sT0nM9KzcoXs7MJdeNXrLqqeaceveyTPxfbvlWWXBg8
 Y4vOogVsBrrJUCbmsHyhoKmHCF3nLbIB4SDDRPc4Qi3YvzT2Egy6yArhqA1wwuaO8MBR
 OQQCUQ2PShEq8Ae56+5AlemX0TMJ2ajZDsRBolIKU4W48auex2TDvYt9F1oYQQD14W/J
 Q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773223069; x=1773827869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iOemOY3GRBon+h/gNtOxQ4VEEGmdm3FWxbjJem+FfZM=;
 b=Qcn8aXMaZOXFYjmSzqgoIx07HkG5Q6m1UFDAkFKc5mk3G6a0i7NV69zOJVgUh5BUZ8
 BZjOC/2cxJ1CaU42tHNzvmpTW6g5JxbXAMYX7RDGMo42MO2KLNL1Am9WgOZXwwvYGUSO
 MQ7rsPX8WJNDyqhCwEw70ORq3iFi2r42DvcPqLbly90us7f3MZ6wqbBRxV64qePCssbw
 3oos0QtgznCgqi5BVVEzbVbZbvT1owQRlYKQLOWHiX2IRZObgYx22SvADQEcNuT9Q1xv
 NmLAl2ulKERFzEk67N2YmQ3aiUpCN2Qi/lukwN/OL0BYq/AhMiEylKMvJrpYI/1Dh8HF
 j5WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTi0bXtVtK7fhcGNfHRNbgS5mXThAnaPGgoVwongmVHwkAEk0tpb+h2CScvleilfj98iIHMEyngdpeeGrE0HMV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YypJZUfsUqitYort6SAhQxZj0EQkpKaSmbANZ8jO35QdoNTzEe6
 eL80w9qjRv22G1yoqnXxLIDDzCCc6KJcmtY2Yv5+EJvtnYYmyf0Zg6QF
X-Gm-Gg: ATEYQzwDK1733jQeJHOKGxmwRvZq2Ts0WYzNEYMtlLsHHP6Oev8AUzRDrSP0SKL4UXn
 hddkpaCz+WH+DZlQiZwdjQskvCDF0AvEGnZZZSI63tqULcshVDEDeJiOXRnBOhKAsFzeDrA4gLp
 b90PCZraeXtnH34PYcjHPHOVcC8mu0pOrZZYul4wKTQCqcV4oq+lo/vmopGfrLiu7XJmk22z0f8
 88hdDONq7XhcfcMJf8XGCUHBNQAQgtxoZzqKU1ZFlSHRBspA+si6FAdhctFH8Hltip4gq0M5skr
 +P/Frhg4Gbfw0355ISWefKnUJFUwyA3Y3foO2ntzcUMHXJKEtYBQFfXXXqIhbsa6CPpjMZurLg5
 RbWC7gKqfA6lKMWB/62wU//fq9DUNY+cWwIJ5KyQXXa67ggm5vjidxJf7gHphN/uupFTzFBKhSE
 8FguQqPcsiw7ZGZY8w7kkn+Lz/P86n19BcCqiLawuLXHHzw1L3Zl8Z8ZSdZenY
X-Received: by 2002:a05:6a00:1304:b0:81f:3fbd:ccf with SMTP id
 d2e1a72fcca58-829f7094b3bmr1933452b3a.23.1773223068600; 
 Wed, 11 Mar 2026 02:57:48 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829f6dc83cfsm1799712b3a.7.2026.03.11.02.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 02:57:48 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Date: Wed, 11 Mar 2026 17:57:38 +0800
Message-Id: <20260311095738.4177239-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
MIME-Version: 1.0
X-Headers-End: 1w0GKF-0002dO-BA
Subject: Re: [f2fs-dev] [syzbot] [mm?] [f2fs?] [exfat?] memory leak in
 __kfree_rcu_sheaf
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
Cc: lorenzo.stoakes@oracle.com, jannh@google.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 Liam.Howlett@oracle.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, pfalcato@suse.de, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, akpm@linux-foundation.org, sj1557.seo@samsung.com,
 linkinjeon@kernel.org, vbabka@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

#syz test

diff --git a/mm/slub.c b/mm/slub.c
index cdc1e652ec52..f029003e7368 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2629,6 +2629,7 @@ static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
 
 static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 {
+	WARN_ON(sheaf->size > 0);
 	kfree(sheaf);
 
 	stat(s, SHEAF_FREE);
@@ -2660,6 +2661,7 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 	return 0;
 }
 
+static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf);
 
 static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 {
@@ -2669,6 +2671,7 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 		return NULL;
 
 	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC)) {
+		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
 		return NULL;
 	}
@@ -5027,6 +5030,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 			 * we must be very low on memory so don't bother
 			 * with the barn
 			 */
+			sheaf_flush_unused(s, empty);
 			free_empty_sheaf(s, empty);
 		}
 	} else {


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
