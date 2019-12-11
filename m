Return-Path: <SRS0=No8/=2B=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50E9C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Dec 2019 04:47:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4432208C3;
	Wed, 11 Dec 2019 04:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aUrtd9Z4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="L09nWIIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4432208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ietul-00080I-9Q; Wed, 11 Dec 2019 04:47:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <viro@ftp.linux.org.uk>) id 1ietuj-00080A-Iw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Dec 2019 04:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EnsBwnoej1b4xMOB/MXv4rQx38sqvAEn9Pu5P9tg2uw=; b=aUrtd9Z4ma4dehCjojAFWwYst
 HKCvIxsQoaaJFbaUVuqLUtJ0Q7vZi4RIohKPpMvAcZwozbyXcd8gJCJ502Ow0Ip+dcepB9z8ZRtsG
 +EoqgUU9XpPi8meAelwCZPbOiabSFsBnvQuxG/g4LUciQ/lhQVUk7agZN9KL/rBJYKve0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EnsBwnoej1b4xMOB/MXv4rQx38sqvAEn9Pu5P9tg2uw=; b=L09nWIIbpH9gjGd3pnPxdNvMBJ
 G0q7lD2kwMyTatJTcTkAtbRwdATFo+B7q6JmI2UDGdJrVOH/1r49Eh6JKfkvL3VZ4L8WiWigK4NKj
 ZOSpb5zYRqQRQvJxHQMS/N2YUC209JQdSXgN878ldFvOjCDebRPrj9lJ6POY5XrmJ6BI=;
Received: from zeniv.linux.org.uk ([195.92.253.2])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ietuh-000k2H-LP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Dec 2019 04:47:53 +0000
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1ietuF-0004dd-CH; Wed, 11 Dec 2019 04:47:23 +0000
Date: Wed, 11 Dec 2019 04:47:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <20191211044723.GC4203@ZenIV.linux.org.uk>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Headers-End: 1ietuh-000k2H-LP
Subject: Re: [f2fs-dev] [PATCH v5] fs: introduce is_dot_or_dotdot helper for
 cleanup
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
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Tyler Hicks <tyhicks@canonical.com>, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Dec 11, 2019 at 11:59:40AM +0800, Tiezhu Yang wrote:

> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> {
>         if (len == 1 && name[0] == '.')
>                 return true;
> 
>         if (len == 2 && name[0] == '.' && name[1] == '.')
>                 return true;
> 
>         return false;
> }
> 
> Hi Matthew,
> 
> How do you think? I think the performance influence is very small
> due to is_dot_or_dotdot() is a such short static inline function.

It's a very short inline function called on a very hot codepath.
Often.

I mean it - it's done literally for every pathname component of
every pathname passed to a syscall.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
