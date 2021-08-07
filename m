Return-Path: <SRS0=9WZ1=M6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0EC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Aug 2021 16:56:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AEE61004
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Aug 2021 16:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41AEE61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mCPcI-0004Jz-5W; Sat, 07 Aug 2021 16:56:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1mCPcH-0004Jg-0p
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Aug 2021 16:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yKqt2xJsysPZOY3vNxOuFJIPK4PuA/tmDqw3BX5iBDY=; b=EOwbackjYn/R6eAxBEfsCWyi8Z
 p/WP2K6gZjS7qoxhPF211Mo89PB4O/HN/JXtF0QRDWrYZoA6GVNQ4jETt4BvtYlSMuzMJ764bkccw
 b02r9MY8ov/TI3heFBKLmip/+lrogMCoKffhywGnDnD0WsgKZ8udMcUPKOiX7LgIbJgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yKqt2xJsysPZOY3vNxOuFJIPK4PuA/tmDqw3BX5iBDY=; b=JaFSsPaKrB4I8FKmVEdVN2ulRw
 8stG+jx/AarW9hF/U/GPDladb9HiQtz6eR4tCYjYMkaaXaShI/YEkRJAP6Zuy2AChSW7pBGumd+xV
 3cpQBSjPdcGiWXY80CiWao6F3cAJTtI/VxBiOoyXstvMq3UfKxc9jItR67yGta2cLKuw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mCPc9-00076f-6u
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Aug 2021 16:56:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E104C61058;
 Sat,  7 Aug 2021 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628355353;
 bh=xneXCef3FRjBCnaNoY9tPBcNVJGns+i3iXDMrVO58mU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U9cRwDNoB6btRNhwTev/FroT9STOvybHbTC5Wd7HQsfk7sHA/LRv2Jz4Ob60iTCW/
 vzmIgNeKI+7hn91QKZPej+HhOnQebH/rf3tl/mjl57NIoOFNGY0CORfAKiMPACjmOS
 PZ8VqjW4lyOC4Mq70yCjJYJ9QiLjZdhFC3ajV3x5onW0x0XJI7TsbOBEwAyLd9asNw
 rO6BXHol6p6s0N0TjMuwKbdmtEIaGSBS9maUDC6DR57GirE9fV2eiZb3XL2C7qchwY
 vPdsVBfmdSL7eRL002qBnjdFbCj9AoyZDEX8PCp1YzK9i1qlOyJhaQGb9W6K7rFY4f
 hmJrE1sa3JyxA==
Date: Sat, 7 Aug 2021 09:55:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <YQ67FxJRlfTj5EGy@sol.localdomain>
References: <20210730124333.6744-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210730124333.6744-1-shreeya.patel@collabora.com>
X-Headers-End: 1mCPc9-00076f-6u
Subject: Re: [f2fs-dev] [PATCH] fs: unicode: Add utf8-data module
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
Cc: yuchao0@huawei.com, tytso@mit.edu, drosen@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel@collabora.com, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, andre.almeida@collabora.com, linux-ext4@vger.kernel.org,
 krisman@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 30, 2021 at 06:13:33PM +0530, Shreeya Patel wrote:
> diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
> index 0acd530c2c79..6843229bcb2b 100644
> --- a/fs/unicode/utf8n.h
> +++ b/fs/unicode/utf8n.h
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/string.h>
>  #include <linux/module.h>
> +#include <linux/spinlock.h>
>  
>  /* Encoding a unicode version number as a single unsigned int. */
>  #define UNICODE_MAJ_SHIFT		(16)
> @@ -21,6 +22,11 @@
>  	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
>  	 ((unsigned int)(REV)))
>  
> +extern spinlock_t utf8_lock;
> +
> +extern struct utf8_data *utf8_ops;
> +extern bool utf8data_loaded;

The 'utf8data_loaded' variable is unnecessary, since it's equivalent to
'utf8_ops != NULL'.

Also, there are no function pointer fields anymore, so this really should be
called utf8_data, not utf8_ops.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
