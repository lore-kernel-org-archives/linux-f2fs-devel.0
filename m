Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50D6C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 02:42:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjt6A-0004F3-IX;
	Wed, 05 Apr 2023 02:42:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pjt69-0004Et-Jz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 02:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fSgxrIJzJER5m+pzdIlnzDizOAdjIdlBCe5BODYGe0g=; b=hDWu6O02CEQdqAb144v/FeryhD
 0P5Jd4n7jxjnkqzaprDrQiISKk1LyJt8crALQF/ivyMS/etMGLsHnYJ4iVm9IAAm3iQJbMJ5/9JOI
 pUs7gXW+NtIYvu+M0B5DhXD8pr4Ozdup35NlTrn+LgWPYZoxLt8fSVm0J66Cc41Omxtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fSgxrIJzJER5m+pzdIlnzDizOAdjIdlBCe5BODYGe0g=; b=Cuhh1ZhQnuAoXyc7f+N/O1vwiL
 jskkLpHxuxmHwXhOX7wVxLRYNJ0rRTxhAJ1oFzWkXFK2VBHNmqxGQcxGT/0XUoLHOPlVLbbY728Ys
 HMlzC08RY7FVEHjg3PsZg2I1+Tl9tw4pYx4K/KYGP4+ebLZgS0WvZuFyTeRUbdOYV4Rg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjt68-00FcPj-5B for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 02:42:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB7B863854;
 Wed,  5 Apr 2023 02:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E250C433D2;
 Wed,  5 Apr 2023 02:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680662522;
 bh=LRvCEbZX7PFF5LKWejNln0Ezi9mXPo/nLruBdPi7Q6g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=btupqg2jLJ6NzEKRnMhqpVDn9yJOIMqiTmpFS9GWjLMvqAgoTY+9GW7NmNh7mMcmC
 SeBxdkmKs50CO5dk5nMBjz0Ff7Q4fqsgIt/6L5s2RzpvPbRXPZrFI+x8+awpaE1LmP
 bXV1aazE6iuHVTIP26qAt8keDnaVGEY+yKlBMdBBxh58arR4M6+MSW/tvp9dS2j997
 siWc5B+zk1TJvtuygO9vG+/zy0hT9Pt06F0y2jdaKSD6MLQIG3A+pEgkSTga+7bkgJ
 F9YcTFw2JZm8LIUBFjq9zPymaGcYcUW4RlVQx173DoFQfQFwMOvLXxWex7P4tX23PT
 tS5CNvzk8Z8XA==
Message-ID: <a6d9887f-1ff0-fd43-85ff-e6fee87bbe84@kernel.org>
Date: Wed, 5 Apr 2023 10:42:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230330164948.29644-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230330164948.29644-1-frank.li@vivo.com>
X-Headers-End: 1pjt68-00FcPj-5B
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: merge lz4hc_compress_pages() to
 lz4_compress_pages()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/31 0:49, Yangtao Li wrote:
> +#ifdef CONFIG_F2FS_FS_LZ4HC
> +	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
>   
>   	if (level)
>   		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
>   					cc->clen, level, cc->private);
>   	else

[snip]

>   #endif

[snip]

> +		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,

It's weired that whole else xxx; statement is split by #endif.

What about?

	unsigned char level = 0;

#if
...
#endif
	if (!level)
		len = LZ4_compress_default()

Thanks,

>   						cc->clen, cc->private);
>   	if (!len)
>   		return -EAGAIN;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
