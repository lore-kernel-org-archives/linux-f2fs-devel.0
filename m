Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604F5C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Apr 2023 09:41:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pry7x-00015X-B5;
	Thu, 27 Apr 2023 09:41:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pry7w-00015R-6S
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 09:41:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WJBODaLFgcvFwhJbmQjl5wvoOld2WlnQq7DtxJg8TiE=; b=X243irkkVFXUYtLxABHW7su0CX
 oYSME49Y6/lI+U9b2bh3ONo64npmrOnY95StpeBYbUhFuB7qr09o3MkSmdj9VUssHu+kZYmg7GZas
 8+OOBb9pMfhIwGj0xhPqxH2/ojz95FQfhy6RqcvY17Xds+1nnDic/qr2uYv6CnIfictA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WJBODaLFgcvFwhJbmQjl5wvoOld2WlnQq7DtxJg8TiE=; b=kwAD8pOLeeUnZPp3psyKjR2gJ1
 Wja/X8fMy/TuDX+wTUJ/bX4DGWuoig1Zm96diP3B41UnrWlY4bmfSjctnHg+CAN5KNycqVHy26Y8F
 b0BTQFaqqIHr4MdHfzPa+oLqSq+ESpbbZi6viXc7RI9rEoY7UnfBOyfi4VuYz0sDb9ss=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pry7u-0003fl-JG for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 09:41:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3961D6396F;
 Thu, 27 Apr 2023 09:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98685C433D2;
 Thu, 27 Apr 2023 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682588476;
 bh=125u3tejLNQJF6kLDB/UavqRQ6HJYDcAsZo9N4ED0EU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lz9bLlPFKGR3jYl/Cwqy8ldlc7wA21wcKS+5oQGFK1XphjkebhNZTqbWxMfTfDdPj
 LNBK5XUnc6lRfTSyKhZwyGHskrzj+BoqElDDDzKGrTAJXBTi8W8YAL1wYamQYBK8Mx
 UPfDoJmGcgAoZepIT43nl+aklwhqxFQ+4Y365UbsJEBxKr2vxfMQXDbCmntX4zoadI
 /L+YAp0IJD/2Qjrlo6T6DHIAffWIh1eOsNvn9ajGPX8e50n5I67yT64kIg/9SlfWxK
 siDlNt8ygwRiXHnEvhtxwztYzNe6LpFaj4q8s8cC19vSRqGYigZKmIArmbr9qlt+nr
 6m6Q26iIzRNzQ==
Message-ID: <444a931b-1122-c4b5-52eb-f45ed146f05b@kernel.org>
Date: Thu, 27 Apr 2023 17:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230425160611.79848-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230425160611.79848-1-frank.li@vivo.com>
X-Headers-End: 1pry7u-0003fl-JG
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sanity check for proc_mkdir
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

On 2023/4/26 0:06, Yangtao Li wrote:
> Return -ENOMEM when proc_mkdir failed.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
