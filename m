Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3FC61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0fRzN6rgv1HIU7xwPz93vrtnRr7XMyexQ09jtjtrxac=; b=k6pUZWcGqk+Jy7I0/hPtNHBalb
	4KuNzALGDXkEZUr0t0sAK2gsEAeQzWO+6an0xrsuDlU6K6kpF6Is7iLhQH74kGcqKZ/9xNuEKK0BI
	QooGASRYYL/76ejlceroLlsN6ysSYtpgxbKHFsKQxCzu0OMkXgvaRUvHNBid1HvPnvzk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1gSi-0005aJ-13;
	Wed, 02 Sep 2026 08:36:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1gSg-0005aB-6k
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:36:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f5eOwn4JdKEKwT71A+VnTtLOHomJI4yFlxDqRGgYf30=; b=KvGMwFtCcgM2s/zQMbS1gCqSc9
 C6pSkSMWAI0BZ/BTv3cXuPbeVRZwyq6fMAMsBJMj5Ep4disY/G9jj2ZXwE0coegt2zYMNiPv0UNAa
 CRPgr06Og04aSLTi/FXYBRtXSiB7CaRkAryPWAuiA4McjUFXKNOHHVkM/AUej9ndSBxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=f5eOwn4JdKEKwT71A+VnTtLOHomJI4yFlxDqRGgYf30=; b=BXG0bfFibFYO7fQrcSwCVA/ea7
 D2KIbvHoX9uC455eWYOVZ8p4WV6qTOQLfA01B0g9Uo3V8RMWmtmtx8Y5xgGbg8sqNCiJg0eOS6CzG
 MMS/DE9E21p7V3CfolIncSmkTBw5jI6xilSYqorAMZuloZB6T5cFyFqAFp9g6WdZg/oQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1gSg-0002bG-Eg for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:36:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE52B600C8;
 Wed,  2 Sep 2026 08:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481BC1F000E9;
 Wed,  2 Sep 2026 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788338204;
 bh=f5eOwn4JdKEKwT71A+VnTtLOHomJI4yFlxDqRGgYf30=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oCpRUK6hGZAnNe/9VlvqRRERWIDNWVEVVKtudzWuJTP+1lLIJf1/MnQHhrdxtDdK/
 Ih5bJU5HOALojvj6Uox6o1Ogt94tLUfYRBNJNK/oz7G4dEuyyXPHMoNZVA7OFgEL11
 TIu2JbQOe4moDI3WLEdlZYgYA88XrzQOpgbXXiW7D4VJUDR4p8x+WJbank/5WRUoFB
 JhzbUyV1OZH34fPVogFzyrupaEyAroLhZPrMu6KspLP6+t2nqBcEM4qpdj2USOpxxb
 h7CnBz/xWjvN7fkoBh4RXuWMxNb0TfXzJBX239GVhnBD5+B5z+VHqcX3nsSwEOBeUq
 bvd0bnhxWl9Tw==
Message-ID: <38c7a280-fb53-4b84-ba5f-9656c2121f3a@kernel.org>
Date: Wed, 2 Sep 2026 16:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260901140849.3405971-1-qiwenjie@xiaomi.com>
 <afbed6d5-0c11-4041-ab8a-68f0264dceda@kernel.org>
 <20260902081633.520538-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260902081633.520538-1-qiwenjie@xiaomi.com>
X-Headers-End: 1x1gSg-0002bG-Eg
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/2/26 16:16, Wenjie Qi wrote:
> Hi Chao,
> 
> It does not miss UPDATE_INO. The mode argument only selects whether to
> wait: both APPEND_INO and UPDATE_INO call
> flush_workqueue(sbi->evict_wq), and both updates are queued on the same
> eviction workqueue. Therefore, one call with APPEND_INO also drains
> pending UPDATE_INO work. A second call with UPDATE_INO would flush the
> same queue again.

Alright, how about call flush_workqueue(sbi->evict_wq) directly and drop
f2fs_wait_for_inode_record()?

Thanks,

> 
> Thanks,
> Wenjie



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
