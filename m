Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897D7CD98F6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:MIME-Version:Message-ID:Date:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wIKGMmZ41qkPeRLhNPtr2poaamNdAuEYMjBzUjabRrg=; b=PgwZ5ukdlW0UIxsGM5r2VygWm6
	/Nflu2YTacQyZskGIO1vH83bYtcRmBvfATcXEbcn+kK2HwGPLNOB9odPQJ+BCmQbheeHIZ0XF5HAz
	2DlPYfuWfJ0iU7wiEUnvzcDeqV26pf2oLwBYiefCRKMmMvwzB1xL7JnLHwS1SLLqn52g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbVQY-0004Q9-GO;
	Mon, 22 Jun 2026 03:34:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <s_min.jeong@samsung.com>) id 1wbVQX-0004FZ-DY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 03:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:In-Reply-To:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IfgpQAD/vfdz21gCxgMtgiheUqVviDey2ND7ZWyteeM=; b=gsSmoi9hKIDBwMEnxOlVoEpNMO
 HtiqJScOlVBMXXIo0Ga/hZFL96ukN9ZCN1hBfh7u5U78/4X2Aq2VH43uB3CKq7XpvHBOsozAisxGe
 A4WBgFLzH+6RYa/kjaGNO0K0eOBy1sxmy7S7RrfqUlQWuzmRfJeCAHVSIvMWDkLjoaTc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID
 :Date:Subject:In-Reply-To:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IfgpQAD/vfdz21gCxgMtgiheUqVviDey2ND7ZWyteeM=; b=XApCRBed/2tuToQ9LIKjy3YlRz
 UxPfeFqSUaKuabO87PUQLO+S1BPc1tqR2wdBEC+dzLS0Sm63EYqtlOeaR5pDH0pvNx0EokA9svLAp
 xZh+j/5bjH4kcAb2SBT1K50KrnxQSUzWBy/B94B9qqHHWT1QpIC9Y7DVoPIwAiVHX/Ok=;
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbVQS-0001Ht-Mz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 03:34:22 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260622033414epoutp020489c2588a057edc2388c5fcc5509d40~7SdRuIpCL0472404724epoutp02J
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 03:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260622033414epoutp020489c2588a057edc2388c5fcc5509d40~7SdRuIpCL0472404724epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782099254;
 bh=IfgpQAD/vfdz21gCxgMtgiheUqVviDey2ND7ZWyteeM=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=bnpv5MWBozl9ow31u4TLR+Ab0rZlcTZd3P1Q8zyiHkmpIpzJEEWxADJq4SDmkzIxv
 PfmYRa5rqb752wyNrz4LCQJcbBPzye2vTz5y8xGsTZjk51a5+KC5oDTUBsmegvIAnR
 t/49ULof9YJUY/LzfkOsIHRrJa4C2bVLTh1ww9O8=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20260622033413epcas1p16ac8053f02c6b2cdba979fa7832008d8~7SdRVWwYl2393023930epcas1p1R;
 Mon, 22 Jun 2026 03:34:13 +0000 (GMT)
Received: from epcas1p2.samsung.com (unknown [182.195.38.190]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4gkDMT4g16z2SSKY; Mon, 22 Jun
 2026 03:34:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20260622033412epcas1p401bc4d22a9f3993d0fb9a333a6b0890f~7SdQUEhmV2631926319epcas1p4b;
 Mon, 22 Jun 2026 03:34:12 +0000 (GMT)
Received: from sminjeong05 (unknown [10.253.99.183]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20260622033412epsmtip2628584a49fe0275e4b98e7dee5379549~7SdQNfLYZ1419614196epsmtip2b;
 Mon, 22 Jun 2026 03:34:12 +0000 (GMT)
From: "Sunmin Jeong" <s_min.jeong@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
In-Reply-To: <d91b17e7-58ff-43a6-855c-bbe7bdb067d2@kernel.org>
Date: Mon, 22 Jun 2026 12:34:03 +0900
Message-ID: <00a001dd01f7$fe359fe0$faa0dfa0$@samsung.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGyqYFiX2zgyGFAKurllELkdaoPRAGJaRfHAuyyhIW2euuJsA==
X-CMS-MailID: 20260622033412epcas1p401bc4d22a9f3993d0fb9a333a6b0890f
X-Msg-Generator: CA
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f
References: <CGME20260622023853epcas1p3d15698d1e456cc549da18ac2674e1f5f@epcas1p3.samsung.com>
 <20260622023805.3620189-1-s_min.jeong@samsung.com>
 <d91b17e7-58ff-43a6-855c-bbe7bdb067d2@kernel.org>
X-Headers-End: 1wbVQS-0001Ht-Mz
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to round down start offset of
 fallocate for pin file
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
Cc: 'Sungjong Seo' <sj1557.seo@samsung.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

>On 6/22/26 10:38, Sunmin Jeong wrote:
>> Currently, the length of fallocate for pin file is section-aligned to
>> keep allocated sections from being selected as victims of GC. However,
>> for the case that the start offset of fallocate is not aligned in
>> section, the allocated sections can't be fully utilized. It's because
>> a new section is allocated by f2fs_allocate_pinning_section() after
>> using blks_per_sec blocks regardless of the start offset. As a result,
>> several unexpected dirty segments may be created, including blocks
>> assigned to the pinned file.
>>
>> To address this issue, let's round down the start offset of fallocate
>> to the length of section.
>
>It's good catch!
>
>>
>> The reproducing scenario is as below
>>
>> chunk=$(((2<<20)+4096)) # 2MB + 4KB
>> touch test
>> f2fs_io pinfile set test
>> f2fs_io fallocate 0 0 $chunk test
>> f2fs_io fallocate 0 $chunk $chunk test f2fs_io fallocate 0
>> $((chunk*2)) $chunk test f2fs_io fiemap 0 $((chunk*3)) test
>>
>> Fiemap: offset = 0 len = 12288
>>      logical addr.    physical addr.   length           flags
>> 0   0000000000000000 000000068c600000 0000000000400000 00001088
>> 1   0000000000400000 000000003d400000 0000000000001000 00001088
>> 2   0000000000401000 00000003eb200000 0000000000200000 00001088
>> 3   0000000000601000 00000005e4200000 0000000000001000 00001088
>> 4   0000000000602000 0000000605400000 0000000000200000 00001089
>>
>
>Fixes and Cc stable line.
>
>> Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
>> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
>> ---
>>   fs/f2fs/file.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index
>> 2c4880f24b54..3954aea43bd9 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1906,8 +1906,13 @@ static int f2fs_expand_inode_data(struct inode
>> *inode, loff_t offset,
>>
>>   	if (f2fs_is_pinned_file(inode)) {
>>   		block_t sec_blks = CAP_BLKS_PER_SEC(sbi);
>> -		block_t sec_len = roundup(map.m_len, sec_blks);
>> +		block_t sec_len;
>>
>> +		if (map.m_lblk % sec_blks) {
>> +			map.m_lblk = rounddown(map.m_lblk, sec_blks);
>> +			map.m_len = pg_end - map.m_lblk;
>
>If pg_end is aligned to sec_blks, but off_end is non-zero, is there off-by-
>one issue?
>
>Thanks,

Thanks for your quick reply.
I'll send a v2 patch.

>
>> +		}
>> +		sec_len = roundup(map.m_len, sec_blks);
>>   		map.m_len = sec_blks;
>>   next_alloc:
>>   		f2fs_down_write(&sbi->pin_sem);




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
