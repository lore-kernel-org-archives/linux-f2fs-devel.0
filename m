Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760C3C624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7CNeC4dDPdGk4GYPKz/kTPrYidHBYfk3RkFImhgdBk=; b=ZDImB+OXCYdCLfdAkaeLYMWwfp
	p6zKzm9NTyUAXFVKrKuhz7r/mQqu/ruMAANFNA30LITfs8G49/QeHhTa5g7eMcoy5sYQ9rF7QZj+v
	RRjuyiXMDC7peQfxAPRTjJXHqoTfYhytbfhE1pbL8jUqH0U3zrvyFnGsgLSGHoEgI4IA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2cjC-0007E6-I8;
	Fri, 04 Sep 2026 22:49:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tz2294@columbia.edu>) id 1x2cjA-0007Dz-OO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 22:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=; b=UigwFu3TATJzYMKypa2OLwQb3U
 8czoabDPPOW7m/LJhR/9GfzUBrwsCv8KRl8xtCBl31cKePhNNgAk3Jaetr3KdW1CdLOTCB1pCciSC
 1k3xtdKf7tptj7NTlkTeRG9Q2xeP7TjlbCfgS54IDha8IeNdWdijKV1DYqJ5sbsYJIp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=; b=dGFBQVgzmEazeOGrfl2MIBbetY
 I84siFuQZHGbY94DOxm5KVdCEnjrtYtLlpPHn2zrNgp9/QYt4dIO6KyEGHaNBikU92Qf5h7UeL/z3
 96+DC2iKyPxZbj2jI+lwuhQcBlIhw8dBA4/vqGKZIyLy+JOPvvqZDN5FRjW21FeGmefQ=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2cjA-0003kQ-F0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 22:49:45 +0000
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684MWfRb3596357
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 4 Sep 2026 18:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=NS3I
 WLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=; b=OM83EIbeyrJBmKFxiBn7
 95BjxB368qVNGNObkjZ85O1d248QOiUYlzhhJJep+Gt6Hi2B8Fzo7oVG64eJc/tj
 zbc2s9qp5g61Kxn9jIQmS3ffGdAlGQCLFIZHun44tpLrXKQNNfvb8FNBH5XRYio2
 Z0cVo9Dhz5NYwVILy/CkqWJ4AHXPq0IB3wvtxsLVRMEl30S7UHiN5mLrnAZYCkPg
 El3m/66187L/MxMuSPzMn+/WT6GRdkqqrMx3xhVwRJ1iy26arqEVzNfdiHL4NoDp
 xnLYfSKwSetCrD1jSwhPGIAgpUmWjZfBSh9+fhBno0Kz/ApUcGuNj1MCJ7bpAC3u
 VQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gg0a83krj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 18:35:11 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so254053085a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1788561311; x=1789166111;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=;
 b=IN9/56EYhwoakgM80Al8FDy4njUiA1BmvAxwKR++C3fLXG0GpcKzH9akBy4tB0QGaN
 oj496RR91FxkJ6ze67PWujg7sHEpiLrymTDPcALYUp+DNVToZ9Cme6Ie8enJbZ8tbtjP
 LZWqKMb23aDwAOdwQKEAuSmgdn4IwfW7YgH7RjUMgs+FiL6+fWZPDNCMOmIumaeGzq0e
 mjSlUbVqO8lZsZXsekPpX6AEWzY4pk7oyhHletFVWnHnkT3dyCHtUIJPs/idy69imSdp
 /PN8nVTWEeJyxIec0cs0svWGGBPVEuq0mjGH7yt6Qm9brqjVISBgJ89W/ykj3w3RS63h
 H8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788561311; x=1789166111;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=;
 b=CN02qutD7BWh5yye1BAebviVPt2jCot+re00+BAy689l7KouueR5HGKDL9bFsrJKwe
 MYoD+4O0QYwUqd9y3gzpRLxbbmtSyxoQeixJBpxwfrvgfuhKiwtw/RwPKLepUslZTrek
 ye/8W0veLgGO+gfGLgUhotjbogKiKnonCFdZm1nKuDMT6gtoxGwLpXDPZqY++fgEp9Hr
 B2TUFxe82725tzh5du/IXda1bL6MgJ+M7FDwNHWsGvjCUoqQ5T6zIYJUe4JBYkNvSuIv
 UnZw80DG/tT3ZZ/123+Fnsr76N2nAGjBWygq9Ot+jZPjFXQizNRayrEU1FITlu5b0Kui
 +yLA==
X-Gm-Message-State: AFuF++l+zIxwxCC67w0ThRDBFTP4XP0/U3ytp7T2O4P//vtzggNT6fiM
 uKbP5eKi/sWVvDWwgGlJ3lvVXJhd+g8FhA6SW5EVM0C1212VIxIh7quoFOi6Z7iLU9xOAxkNAvr
 uC/gUTZx5LJOR/wXs7qHbxQix0JPkKmWSgn5M2t5HTB+WmbNTXMj2hp69o4EwHGjphOFLV8bJwU
 0=
X-Gm-Gg: AYBFou2uSabsJi8rYcmvsoNKvce6ZCG3/QLhPYny6lhwQXA/JOOUR1qxLVPfE3PF3U+
 3rd8Y00yC13EPuicemNqvUSNGhRnheKWTS4/lzLOeIIuKXc9WOgGJdJPMEUoFUWwRAJnKPTDOkt
 Crn7DSztSbwfxpLfqpc5Ke2pmGyWLYl2FV+mBY808JrDe0TURkT94tCaVhF8LV5yqZSMHE1cGQ1
 Eaje56s9joFccU8sodErBFw9q3cE4vtMn10lM/Cnt1Lb2r6n8DousjCVCViRW9R52neU3uA947i
 TTNqWFKbpUfp3fe17jkyw/dvplIWTpmSTdF7uahPKMf9XHuWQX7H0AMgiU+m8OYA26ZiYEnCLVE
 2XIig6SRlnRQM2grRe78JrzkwtMACFZHZWiaCr/+vWcrRw7DjcCft
X-Received: by 2002:a05:620a:44c3:b0:939:8905:ce9b with SMTP id
 af79cd13be357-9398905d927mr531684485a.17.1788561310785; 
 Fri, 04 Sep 2026 15:35:10 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:939:8905:ce9b with SMTP id
 af79cd13be357-9398905d927mr531679985a.17.1788561310278; 
 Fri, 04 Sep 2026 15:35:10 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-177-158.net.columbia.edu.
 [128.59.177.158]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040664be1sm31193686d6.18.2026.09.04.15.35.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 15:35:09 -0700 (PDT)
Message-ID: <789e5449-fc8b-4ef4-9571-26abd514681b@columbia.edu>
Date: Fri, 4 Sep 2026 18:35:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX9rBwfH46x9DL
 6T38K5lYG5Ybbd3nzK9cgb/PP2iy4u+xVOCzAw61K3w7+kEprO1Kttu9d8nUO5HSwHaZlZWzYt1
 g+Vq0WWdIhyQLpVlRiII/7e+dLW+tlIoDdcROaHhIne2l460ndpw
X-Proofpoint-GUID: _6KEjtvK9L0CZGhiby5_hIpbM9eExUX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfXxslxTAhp+Ibx
 IeTIUslwn73Zh81XDGObSF9PK+WrjK+/rHA38zDwAEe8t68FcT5hdkyKmlSQ0DpckUayGEVYLJL
 8hdRL99vSkR03a+GIM7g3hWDfg9WG88gUO/W/crV6mZjWxBsluGknvQSEe/ZkM5g4Mx+r1rIXiT
 bkl5SjhZbTrz5gYuLWlkRLQKdKrjBwNVMUGGXyQqReJ9hqxF4IbnbC9jIiSACy5QzaQaNj8+kLF
 /t7XSxYV9tuGDABaweraaqc+UlhFD2tvhbocKoruAhNz4TDB+GnjZ44BwjvWGA05nAtCzVQ1ZEv
 kGSZd7Ikq75B+VLBno76HWGDExDce6auDsKIlIzDBT+W5B+h+kVV0SmFotka6j+R0R+NZCkBu0h
 XWis+wLYKb/EVQsXm8U7wQ0BmHqF0NdsRuX4WhQEfGhbyQMv1bk9JueWGa/NvlFIZZHi9qo+tIv
 2H47p2OdC8yVtU0fHrg==
X-Proofpoint-ORIG-GUID: _6KEjtvK9L0CZGhiby5_hIpbM9eExUX2
X-Authority-Analysis: v=2.4 cv=MZpcfZ/f c=1 sm=1 tr=0 ts=6a9b479f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=IeNN-m2dAAAA:8 a=r4jUT_wghbJ-rGNBW1sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11896
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 spamscore=0 malwarescore=0 phishscore=0 impostorscore=10
 clxscore=1011 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209
X-Headers-End: 1x2cjA-0003kQ-F0
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: complete dropbehind write bios
 in task context
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/3/26 3:59 PM, Wenjie Qi wrote:
> Buffered RWF_DONTCACHE writes invalidate dropbehind folios at writeback
> completion. Mark these bios BIO_COMPLETE_IN_TASK so the block layer runs
> F2FS completion in task context when needed.
> 
> Use the same flag to keep normal and dropbehind folios from merging in the
> IPU and OPU paths. Classify the original page-cache folio rather than an
> encrypted or compressed replacement folio.
> 
> Keep the existing large-ATC completion path unchanged.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/data.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 21f396ebe22..b0fedacfd12 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   	bio = bio_alloc_bioset(bdev, npages,
>   				fio->op | fio->op_flags | f2fs_io_flags(fio),
>   				GFP_NOIO, &f2fs_bioset);
> +	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>   	bio->bi_iter.bi_sector = sector;
>   	if (is_read_io(fio->op)) {
>   		bio->bi_end_io = f2fs_read_end_io;
> @@ -793,6 +795,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
>   	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
>   }
>   
> +static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
> +					  struct f2fs_io_info *fio)
> +{
> +	return bio_flagged(bio, BIO_COMPLETE_IN_TASK) ==
> +		folio_test_dropbehind(fio->folio);
> +}
> +

So I'm admittedly not very familiar with f2fs, but why is it necessary
to prevent merging here? For iomap, we concluded that merging was fine,
as it just results in some extra folios getting resolved in task context
(see commit efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind
writeback")).

>   static bool io_type_is_mergeable(struct f2fs_bio_info *io,
>   						struct f2fs_io_info *fio)
>   {
> @@ -985,8 +994,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   
>   	trace_f2fs_submit_folio_bio(data_folio, fio);
>   
> -	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -						fio->new_blkaddr))
> +	if (bio &&
> +	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +				fio->new_blkaddr) ||
> +	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
>   		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
>   alloc_new:
>   	if (!bio) {
> @@ -1086,7 +1097,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>   	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>   			      fio->new_blkaddr) ||
>   	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> -				bio_folio->index, fio)))
> +				bio_folio->index, fio) ||
> +	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
>   		__submit_merged_bio(io);
>   alloc_new:
>   	if (io->bio == NULL) {
> -- 
> 2.43.0
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
