Return-Path: <SRS0=u70t=6P=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E99C4724C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 May 2020 06:39:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7274B208C3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 May 2020 06:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Wt7ZuKb1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ajE9W/V+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ITMTdeWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7274B208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jUPKo-00012e-V7; Fri, 01 May 2020 06:39:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <guoqing.jiang@cloud.ionos.com>) id 1jUPKn-00012T-Cr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 May 2020 06:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/mcb2FvhqEDcRhiT/KLUXGr3wPUe4NuYg1JLX3+jiqE=; b=Wt7ZuKb1GqM8Kx3dueFXIk4v01
 iuKMfiVKoufZ85ynGAPIl8+2mpETo7gAPxFao7tPVzV3nRPufhrLAjsc2KMYzPddOojEpx2lUvqyv
 x3QcGHSRDHZcg2NAiRt8cA3m2BahUgHGkp9ikv0YXxXwdguIW8riMj9oIvTOludfOC50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/mcb2FvhqEDcRhiT/KLUXGr3wPUe4NuYg1JLX3+jiqE=; b=ajE9W/V+gUFVY5hpjw9Rra9Zo1
 sZaOGu2rJ/hOi4Xvte+6ZhaCyjLH6qMdaJrKZHYxR70gYV8+jQNLuoDC9yM08HGHdSfovnalT9m5Y
 FlQY3X5+wv4fcIz536saS9BWaN7cqSv5q8cAPrz3wDqQyvsACk5Q5YA+e8tvn4Jr7MDQ=;
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jUPKl-004Cwh-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 May 2020 06:39:41 +0000
Received: by mail-wr1-f65.google.com with SMTP id o27so5116998wra.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Apr 2020 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/mcb2FvhqEDcRhiT/KLUXGr3wPUe4NuYg1JLX3+jiqE=;
 b=ITMTdeWM0lw7Wru0eFXJAnEr1Q6q4HFk5v1XlpgZnZbtXLcf3eDkzjU1Bp+lmrZNXG
 r04sUX4E35L8ViJV/N47J1dNlqJhrdWkEypiTBASldElIUtzCm0wbRgGhdzPyB0sDBaH
 LmA1M3tEAM3xu0Mom5/2IrReXnIQPeu+YuGVpy0/n97ySJX978yvonOgogz2mjkcDwNY
 5EaAbXb8Nsdj/6RVMYfucaVhGriNK0nMa2gUmlE1QSnASYuha9TSSXSOUbZknhZuj49U
 aN348T48UXISwMCg/bL1x1wBWSVN0upisb1oHtFw26Z9CcsTPs4tveBe1nLlFMj8LOlX
 5Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/mcb2FvhqEDcRhiT/KLUXGr3wPUe4NuYg1JLX3+jiqE=;
 b=oRADyYURuw57rtU56XJuAELXzZbeJVCyTOVP/7t4mz45VaPNqN7gTou6VHC4W654rZ
 vAknE0rDcLg6WecyE6BsAFRhRLUcLx5YIlaRJa4s5dYH1B5pnLS3c8YhZowEu+06loe8
 JgXaBLdW7xQ67ErFaplq0TXCgXbfDXNC2HWzTti3cr5nE0PfqEW8MeridJR6+UBVzPHu
 tqF4MIOnMmpJHuBJPhvJzfsMYxLBjpf6DW4/DJdgxUL8ogBMRB4d14UpHyC0hwyEASsw
 EHCVaktUdQTHbrBcu9PpUXATu+anlQl3jwp1UDyGqtBCPzrN076zyc5bKffwMmZMBVvD
 vnYQ==
X-Gm-Message-State: AGi0PubVJFRh2L5YGOwO9zYAGapuVqbPaexLQ9g2FSpO0AJU+393FOFm
 gZ/LjvFwzZEReCaSCsqldi7I0w==
X-Google-Smtp-Source: APiQypKr/Cov9lBLfeX8odUPVKbRN1IPp5JWnyg7FEbdsE5fkPQXlhR/GgRBnVvt0v2I8N4upI/E9Q==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr2306494wrp.285.1588315172931; 
 Thu, 30 Apr 2020 23:39:32 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48db:9b00:e80e:f5df:f780:7d57?
 ([2001:16b8:48db:9b00:e80e:f5df:f780:7d57])
 by smtp.gmail.com with ESMTPSA id s9sm3225364wrg.27.2020.04.30.23.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 23:39:32 -0700 (PDT)
To: Matthew Wilcox <willy@infradead.org>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
 <20200430214450.10662-2-guoqing.jiang@cloud.ionos.com>
 <20200430221338.GY29705@bombadil.infradead.org>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <4c177757-7e27-420e-621b-98353ec43ea1@cloud.ionos.com>
Date: Fri, 1 May 2020 08:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430221338.GY29705@bombadil.infradead.org>
Content-Language: en-US
X-Headers-End: 1jUPKl-004Cwh-Hj
Subject: Re: [f2fs-dev] [RFC PATCH V2 1/9] include/linux/pagemap.h:
 introduce attach/clear_page_private
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
Cc: Martin Brandenburg <martin@omnibond.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, david@fromorbit.com,
 Song Liu <song@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
 Mike Marshall <hubcap@omnibond.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>, Chris Mason <clm@fb.com>,
 hch@infradead.org, devel@lists.orangefs.org,
 Josef Bacik <josef@toxicpanda.com>, linux-raid@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Anton Altaparmakov <anton@tuxera.com>, Andreas Dilger <adilger@dilger.ca>,
 Yang Shi <yang.shi@linux.alibaba.com>,
 William Kucharski <william.kucharski@oracle.com>,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <guro@fb.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/1/20 12:13 AM, Matthew Wilcox wrote:
> On Thu, Apr 30, 2020 at 11:44:42PM +0200, Guoqing Jiang wrote:
>> +/**
>> + * attach_page_private - attach data to page's private field and set PG_private.
>> + * @page: page to be attached and set flag.
>> + * @data: data to attach to page's private field.
>> + *
>> + * Need to take reference as mm.h said "Setting PG_private should also increment
>> + * the refcount".
>> + */
> I don't think this will read well when added to the API documentation.
> Try this:
>
> /**
>   * attach_page_private - Attach private data to a page.
>   * @page: Page to attach data to.
>   * @data: Data to attach to page.
>   *
>   * Attaching private data to a page increments the page's reference count.
>   * The data must be detached before the page will be freed.
>   */
>
>> +/**
>> + * clear_page_private - clear page's private field and PG_private.
>> + * @page: page to be cleared.
>> + *
>> + * The counterpart function of attach_page_private.
>> + * Return: private data of page or NULL if page doesn't have private data.
>> + */
> Seems to me that the opposite of "attach" is "detach", not "clear".
>
> /**
>   * detach_page_private - Detach private data from a page.
>   * @page: Page to detach data from.
>   *
>   * Removes the data that was previously attached to the page and decrements
>   * the refcount on the page.
>   *
>   * Return: Data that was attached to the page.
>   */

Thanks you very much, Mattew! Will change them in next version.

Best Regards,
Guoqing


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
