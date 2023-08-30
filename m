Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A9CC6FA8F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Aug 2023 06:12:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qbERE-0002Qx-RZ;
	Wed, 30 Aug 2023 06:12:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hao.xu@linux.dev>) id 1qbERD-0002Qj-2D
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Aug 2023 06:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JMzOvVHk770qYz+7D4bRM3eiaC0WBb12Z/fuZleaQ2g=; b=kIlQ8BROjEi8l1nn/6RIvyz0LO
 UbQK+rTB3UuJFw2+MBFUy65plEDMgtUSLfM/EO9dG+GpitrMitgp+wbymrQK6XteT1Qyh+VrBqYcy
 jt2VsJsE+KorlAZpRp+92jOX8mrWD7L7w3tvCqQFNxUS9bQ0hdCWj/o++y+rYrfPIJ1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JMzOvVHk770qYz+7D4bRM3eiaC0WBb12Z/fuZleaQ2g=; b=CrI9a1vqkGF8prZWzGa1c712VP
 o6Sv5hluZvnQk3DD7LqcEInUgSk7S/ybAIVy+avbPPjpeF5rKlEF6HFXfRLUMyNA7nsKVVXYx5SpX
 XqKBUL8ECLUP1MY/kWAqot0XIcK4B6B1w9DbwFA0EJ1r9J6GtdYjudHNgZ45vG7lmKZw=;
Received: from out-242.mta0.migadu.com ([91.218.175.242])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qbER0-003B6W-JQ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Aug 2023 06:12:21 +0000
Message-ID: <642de4e6-801d-fcad-a7ce-bfc6dec3b6e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1693375918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMzOvVHk770qYz+7D4bRM3eiaC0WBb12Z/fuZleaQ2g=;
 b=n8qZNKHDJ8ZkQN8s6YCFhUc5vlrIehXvAzssrfT4lOFAEgM70y7j9ccF+kTN544/il9mhv
 /Qwyv0zoAHdwAPeCdmanHqcxV7A/7XcL4G5u9c/o5+tWUqR2xZIKUSlHotdEAwwwHhjWvg
 KLK2CGyPGmGk32bcLUct3rbhOUMJhk8=
Date: Wed, 30 Aug 2023 14:11:31 +0800
MIME-Version: 1.0
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
 <20230827132835.1373581-8-hao.xu@linux.dev>
 <ZOvA5DJDZN0FRymp@casper.infradead.org>
 <c728bf3f-d9db-4865-8473-058b26c11c06@linux.dev>
 <ZO3cI+DkotHQo3md@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Hao Xu <hao.xu@linux.dev>
In-Reply-To: <ZO3cI+DkotHQo3md@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qbER0-003B6W-JQ
Subject: Re: [f2fs-dev] [PATCH 07/11] vfs: add nowait parameter for
 file_accessed()
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 netdev@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, bpf@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/29/23 19:53, Matthew Wilcox wrote:
> On Tue, Aug 29, 2023 at 03:46:13PM +0800, Hao Xu wrote:
>> On 8/28/23 05:32, Matthew Wilcox wrote:
>>> On Sun, Aug 27, 2023 at 09:28:31PM +0800, Hao Xu wrote:
>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>
>>>> Add a boolean parameter for file_accessed() to support nowait semantics.
>>>> Currently it is true only with io_uring as its initial caller.
>>>
>>> So why do we need to do this as part of this series?  Apparently it
>>> hasn't caused any problems for filemap_read().
>>>
>>
>> We need this parameter to indicate if nowait semantics should be enforced in
>> touch_atime(), There are locks and maybe IOs in it.
> 
> That's not my point.  We currently call file_accessed() and
> touch_atime() for nowait reads and nowait writes.  You haven't done
> anything to fix those.
> 
> I suspect you can trim this patchset down significantly by avoiding
> fixing the file_accessed() problem.  And then come back with a later
> patchset that fixes it for all nowait i/o.  Or do a separate prep series

I'm ok to do that.

> first that fixes it for the existing nowait users, and then a second
> series to do all the directory stuff.
> 
> I'd do the first thing.  Just ignore the problem.  Directory atime
> updates cause I/O so rarely that you can afford to ignore it.  Almost
> everyone uses relatime or nodiratime.

Hi Matthew,
The previous discussion shows this does cause issues in real
producations: 
https://lore.kernel.org/io-uring/2785f009-2ebb-028d-8250-d5f3a30510f0@gmail.com/#:~:text=fwiw%2C%20we%27ve%20just%20recently%20had%20similar%20problems%20with%20io_uring%20read/write






_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
