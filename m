Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F51C61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERQUqOXDBqnqnR5rWwpZEVtg18HY24TMKf5wpEG+DuE=; b=LJA28RniMtlNQwh5rrLv1xgb0v
	V0IQbn4xOJwrJaQ8M8p38fvhUbrS+bYBUoyWL+9egmgZQ1mcOVi3gjG12pRHnxLQjcCiDzMN3QDGM
	L91F8xikv/dqyn72+5jFZv/pMCiFnd3UTtCZsxt+adI1v3R/AbqfOhh//eYlfADdJxTk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzlsJ-0003kr-0q;
	Fri, 28 Aug 2026 01:59:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzlsH-0003kl-9C
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 01:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lSNX3H2jSZGk9ydw0qd7Md10eKuFR63Mv6/1+OfuhLQ=; b=A9SLCeHeqOzxWZ71Cr56PuVRJD
 WdtkqjB326iD612s/Cr0/rkPA/6HlAfVhNzQVZUIv4DKrfiX9fCMwh7LyU3vnFnW1O2nxHtHfpAde
 MMMKQh7y2+ExfCcIfImoXlZKXP8ptATZ89XTfzda9gin2eALEc03QEW1asoSkuqv7lec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lSNX3H2jSZGk9ydw0qd7Md10eKuFR63Mv6/1+OfuhLQ=; b=GbluN8+c1IpVgXV22UCuMYawHE
 AAPK07Gbk0tLMlbMoE+PM7We8SkKYEEpdesvqHz2EJVtaKEKajKn0nttUKqQ60nvF03t0tu1+yO+w
 FoUAWHyR6n1kM9suz1OzAMuy5JrkhrOTnDUyjQ69SJJXXxMqlYHLohTv+2xzgl9R3vQ4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzlsG-0004sa-S8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 01:59:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EFEF4356F;
 Fri, 28 Aug 2026 01:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998911F000E9;
 Fri, 28 Aug 2026 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787882355;
 bh=lSNX3H2jSZGk9ydw0qd7Md10eKuFR63Mv6/1+OfuhLQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bXOqrXGdenZWSLq1CWh2reV2nnglAEqXqQ93LjbMKIb5yTUg20OSzWPqkx0FbB5/z
 cocwZTE4a1GkAse6TnXIuGCqH7zJp97j4AUcdmZR5+Kp/ejbzWTlQZ7H2bCc9EMBQe
 UxeVQ+zxquO32RoEPdTSgdrpUqgaMsoFgIeID9DtjIoh0283SyZvJSi0vkUv1MXCd3
 ICsZcz5rIKpVuygwmP9GiBHyaiPS9jlFVOjz1QmwbU2YY74FaZZYWzaN8t6JQrugIM
 0Jk4gE0KtcMQko9osxcBlVJuVFJqtlFciDtkr7QWQxgdN5ZfRwlWb+CjbBmScD5QOh
 Bkm8uWZQaEw6A==
Message-ID: <dfd68bb4-6f3c-46bd-9b6c-11fd17da6bc3@kernel.org>
Date: Fri, 28 Aug 2026 09:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>
References: <20260825130126.2078627-1-chao@kernel.org>
 <20260825130126.2078627-4-chao@kernel.org>
 <CACOAw_whg1SO2479NL7d=ScRVrqvwHbPWg1pB2T4nWHdGe+w7g@mail.gmail.com>
 <4880a9a6-4036-4fec-8507-552f1bfc9fbb@kernel.org>
 <CACOAw_zTh8FSqcaQNYcPib+vjoMMi4imS5TTzJBOgxtZN90aBA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOAw_zTh8FSqcaQNYcPib+vjoMMi4imS5TTzJBOgxtZN90aBA@mail.gmail.com>
X-Headers-End: 1wzlsG-0004sa-S8
Subject: Re: [f2fs-dev] [PATCH v3 03/12] f2fs: cache: introduce shrinker
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

On 8/28/26 01:00, Daeho Jeong wrote:
>>>> +       /* Phase 1: Isolate candidate entries from LRU list into dispose_list */
>>>> +       spin_lock(&cache->list_lock);
>>>> +       list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
>>>> +               if (isolated++ >= nr_to_scan)
>>>
>>> scanned?
>>
>> Okay, will clean.
Will change like this:

		if (scanned >= cache->num_entries)
			break;
		if (scanned++ >= nr_to_scan)
			break;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
