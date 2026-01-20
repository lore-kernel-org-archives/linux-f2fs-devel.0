Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8834CD2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XbkQBx3YKzwG1W7wzsfkzHj+Hn+yoGT6YVcD6ZQK3mk=; b=dildcpxYKf5DeitcNEEeu6TpRj
	wtBKLg8uK/PbqNZejlv5pDNxYDxWmdhBUr+0WFnz0KXIaQTuTjhoh3uHiOuT0J6hCt1qo2FPg9Q1F
	Ln9uKtBYje0NZzmCau21p8hepohOZasdYkiCewL4umciHJ5ktjqCFF/Z4k+6DqbJ6TBY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viAzH-0002kp-EY;
	Tue, 20 Jan 2026 12:37:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viAzF-0002kY-2h
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o/S8ItO2oPGhNIAD01PCpd2edHmVS9KI6aD9qpYzwhc=; b=M4fYbuZtSGTBXK0a5UjmRoWsUc
 9tOnhrsVu1oa9sivg1HQbJOLIY2JPs/ZFg+Dpj/WvAjTngL51+R0NyppLi2s/6A32Edxh1L0oHkTj
 ID/6eqQ9MpRZ5ql4xh/FJZNFiTFICKRLy6YLawwwC1iVveMO/um6P5BaiCB3j/9/Z6B8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o/S8ItO2oPGhNIAD01PCpd2edHmVS9KI6aD9qpYzwhc=; b=ACBcXoOYV/KnSU12TBQwTbK9xG
 jSFiATjrGqYD1dsdY3BylzDB28At46+NIyGn9B+MBkgOSfzRlb7CAhiVZ4m+CAVlkS35afkvIdn3g
 dm0bwB/GX3oRfopSTR32PQ83DGOQP1r4OcfQysHhQsmFEf2BG8hgCV3RCwMSgsHGNIGs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viAzF-0002eD-FM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:37:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CE52260018;
 Tue, 20 Jan 2026 12:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650CBC16AAE;
 Tue, 20 Jan 2026 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768912647;
 bh=FET4S4Iot59fXE/tjt2Tz2PazJNX6lN9XTHHf/tP5Wc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=f45xC3nxvBETQ9lAsAcavDXfSqTzcG09/2U6fV7bkhyQgO3UT8ZdDkmB9clbsYVRz
 x+0yypa0mlWVFkg5Et+MO5sysvtEggZJWLrF68zPyED0luVn3uCezGN0ptEAiB87Mj
 M5wgenqyRBw/zMCqtiBW2WJfEnfavk7iJd7qxvarzp5nytcxKlsxsqpXyBQ82mbv37
 eeRg1DHOSxIp/KS77o4Iv+pKJHw9FdMjxZIdm7m6y1eDLL8H/AWRulemibldxhmwD1
 4LRsTAF20p6rAq+4ILsHjrkNIxf5wPR2ZPkZjfqMSNhrALGBV0g/+K8CxolOI6o8GJ
 Rd3JYJwm+qYrA==
Message-ID: <6ae45afa-ca73-4901-810b-c2937a84156e@kernel.org>
Date: Tue, 20 Jan 2026 20:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260115164749.11900-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260115164749.11900-2-monty_pavel@sina.com>
X-Headers-End: 1viAzF-0002eD-FM
Subject: Re: [f2fs-dev] [PATCH] f2fs: pin files do not require
 sbi->writepages lock for ordering
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/16/2026 12:47 AM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> For pinned files, the file mapping is already established before
> writing, and since the writes are in IPU, there is no need to acquire
> the sbi->writepages lock to guarantee write ordering.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
