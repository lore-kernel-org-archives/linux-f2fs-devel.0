Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9944C982C1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJUBPCCl2lfIO2AYaPD+WmPGAx/KVusYphExqO8tw3A=; b=lOwTHEoKGa5Zu2wdI0Ocx8Xh+c
	y6GPp1DXUcGfBShvRtOabMdTkGPbKXnL30/eWNsV/zHoze9fPJsTsRJPua0ZEPjaaoWBW1D+q+y19
	rXgtlWgmUqT/9d5dC+vJi3o8sg7b6l2Y3QRmg+shkFJjT9NpLYJIom5RqwLDs9IJ3Ouk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x72I5-0001Af-94;
	Thu, 17 Sep 2026 02:56:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x72Hq-0001AE-0u
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 02:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1urShVx1CTGS+0Mcr3CJ4cQ9a5WoVlHz6Ell7cT1tM=; b=F56ODq6yCUe6mIN3oNckkvhPws
 qip7cD6qiVCHGl6EOvIJV/cLB8EIrX3ZoNrUZJtW3LE6HTP/aWPvYqjPDHZGDZsown+JlN3sbAnWv
 /fvKenUbLZ93bQUPmE76VLlSVwnkM3n1T8j+G0+ZZ0/4Ewkhs2Q2t/nXRphPkrDQzKKk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a1urShVx1CTGS+0Mcr3CJ4cQ9a5WoVlHz6Ell7cT1tM=; b=fM54S5gN7uqpAN3GnNiOaG8GC1
 ERBW8Gm0n/V78/CXIFeAHVk0edG/PXeShULE8ZpB3y0AzvEn/6Vb5Li+B+ZKeUoZ8LJSYx94QBX07
 x2wdX+cYlG337jM/56qAj9NSIUoyWLKUq7od6LEp//6Qu+1eqxDNVTNBiYdjZy6+Gltc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x72Hp-0002CA-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 02:55:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EDFBA41A22;
 Thu, 17 Sep 2026 02:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28C91F000FF;
 Thu, 17 Sep 2026 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789613739;
 bh=a1urShVx1CTGS+0Mcr3CJ4cQ9a5WoVlHz6Ell7cT1tM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=i32Ppjv0vEOP5iZEgMf7IumbJhRen1Ut4SX/p/i33hZ4ipBThvqa8xPUpXgAakEHO
 JuXuBMeDNKG/r4+aFL+32HQcicvx1qzLEvak3c2/pyFWJW0V3WXr5jANcJKCgLIvK+
 4BGZ8pdSuuDHsr2sD2zCBrzjS1OY8ytgKBwLjXKhmuPryQ75PnFkWlHTd4uOvHCEUa
 8HCJMkH9RG1JP8PC32J06mVnfF7hvuVuRl4A0gC13XHdmBstfwwv7HkxZ1tujumSw+
 c8plW1cVtIywjUaMpOxfmdGXOU4pF2isYvwY5oNvgDNDfikZre3Skl8FROO0rPdKrC
 9FMmS/rorrizg==
Message-ID: <94731ef5-4c1b-4aed-9a03-ab63a4fc8a7c@kernel.org>
Date: Thu, 17 Sep 2026 10:55:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260916015440.2232938-1-chao@kernel.org>
 <20260916015440.2232938-8-chao@kernel.org>
 <CAHJ8P3+0jVMFp3YTse8fbUTSp+jjW+2czxp0NuD__sHG_7UNXQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3+0jVMFp3YTse8fbUTSp+jjW+2czxp0NuD__sHG_7UNXQ@mail.gmail.com>
X-Headers-End: 1x72Hp-0002CA-B3
Subject: Re: [f2fs-dev] [PATCH v8 07/12] f2fs: cache: use node cache
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/16/26 17:15, Zhiguo Niu wrote:
>>  static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>>                                 struct inode *inode, struct folio *folio,
>> -                               nid_t ino, enum page_type type, bool writeback)
>> +                               bool writeback)
> Hi Chao,
> seems this function just only handle DATA type now, so can we rename
> it xxx_data_xxx for easy reading?

Zhiguo,

I rename it to __submit_merged_data_write_cond() for readability.

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
