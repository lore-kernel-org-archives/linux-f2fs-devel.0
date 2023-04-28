Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258CBC77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Apr 2023 01:01:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1psCUE-0007DW-8t;
	Fri, 28 Apr 2023 01:01:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1psCUD-0007DQ-HP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Apr 2023 01:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5If5UNs7lNWjwwu0sqTR+JbEU2JKZAL55uOLmc2FeFo=; b=TnjEkptN0ayRZL78n7szcLY2YJ
 AIKZiZcpno92pmyN88qZPNhp7XirwVuJkKbQqLtuOFzvx+G5lzNKxJwuL51/Zl1Jz580qXZxRjjdZ
 i/jI7CtNc4KGtPQltgAzsDmBnrgO3njRXEuQXYEH3gxeGgquJ+t3AyaKZrabVqvMPPAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5If5UNs7lNWjwwu0sqTR+JbEU2JKZAL55uOLmc2FeFo=; b=G8MBzd2A2NHeId4XcuXDVmdgYE
 fUqfnVf7J+gmDmIRNhyZZG0l6qqIPvw54IjecS75Eq5WE8gz5ODSkPLB5QusBvCMesOJtIXBcaYbw
 +R7QGBM8MRBq1UdyQ60zJMsKfCgikhjdWvqNIAh/SLqYS6P2wIjl2BPFeiSuIw7FVJLo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1psCUD-004usx-MK for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Apr 2023 01:01:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4E215640AB;
 Fri, 28 Apr 2023 01:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A3BC433EF;
 Fri, 28 Apr 2023 01:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682643671;
 bh=Ze7Rmxv3LKtkH1ANVKux+0dOMHgCVGFP+y01bt0LlkU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I6rWayZl6SuHVCf/8UBr11n1a1asSocPamkSOaGi6vbj06tj8muEqTW404vkSnR3+
 TsdZQ5VpiOkBMAWX6jtwTdbcX5p1jKctK+QC6fn2c1gHpr85U2511koywBTjOidwHE
 /Ie8UdGjW9VynvGZrVkg9wJRa3yMJDhtShIAH0CEVxB0117CRDdXT6Y5pQiLlIEeKn
 P6BOJjMKmEV4+C5zxFDgyALRpGMYux6cUE8Vg8pNnUJ0qXxV+JKngDVkUE4vIDuLIg
 RJ4SNU3Y5Jzba7bMjtwNTRue43/yScFebLfH9tf3BYxeAFUjKdugRhAVv79iHe8vPg
 8j+LAdk1NMw3w==
Message-ID: <ed6409e8-1ae9-e567-9117-4e9ac7cd7d69@kernel.org>
Date: Fri, 28 Apr 2023 09:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dan Carpenter <error27@gmail.com>
References: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
 <2867d5b3-c6cb-49fa-854a-0f58f9a5adb5@kili.mountain>
 <ZEqikAnNmjMxuSoU@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZEqikAnNmjMxuSoU@google.com>
X-Headers-End: 1psCUD-004usx-MK
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove some dead code
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
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/28 0:28, Jaegeuk Kim wrote:
> On 04/18, Dan Carpenter wrote:
>> On Mon, Apr 17, 2023 at 10:51:46PM +0200, Christophe JAILLET wrote:
>>>   
>>> -	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
>>> -	if (!ret)
>>> -		ret = ret2;
>>> +	ret = filemap_check_errors(NODE_MAPPING(sbi));
>>>   
>>>   	return ret;
>>
>> Let's get rid of "ret" as well:
>>
>> 	return filemap_check_errors(NODE_MAPPING(sbi));
> 
> Applied with this modification. Thanks.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> regards,
>> dan carpenter


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
