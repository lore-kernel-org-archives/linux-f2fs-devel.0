Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C22C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jan 2022 18:55:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n6zpf-00051Z-U4; Mon, 10 Jan 2022 18:55:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <longman@redhat.com>) id 1n6zpe-00051S-EY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 18:55:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RYyRRXLaDdfZNoFNwWil/ubp0G98nyL4pk/ZhirIiec=; b=JX+PXtjhAKcAE3OtUHkA9EtZdx
 sd5Fbr2+EN5CBCigGGSd/Pv5vT4kOrolOChCr+4cZZT9mcy1H4WZLjO85VrtDnBvstXUs1kKrDhkq
 jLOIgVxu6NVU5R6F1ha5E1a7FVOMqimtx+YiVaVBIGv1B0MJcGKKzpvR8UVSJeJ/wgnY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RYyRRXLaDdfZNoFNwWil/ubp0G98nyL4pk/ZhirIiec=; b=KVXmWwbaPjNusty8d13WTROyD+
 oZHdTOGvTO7OudCxn0Opno7LWg2EowbWib7taKf+p+pkrdzKYZIrKt+u2fJVkjVXzKSNEGqRd8Qva
 hX2v2ri46OAKfDxat3nN+cl4uZD5DaM0B70m5XATu2KZMjW5jxNReUZBqdacLVssreEQ=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n6zpb-0006n9-4s
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 18:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641840940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYyRRXLaDdfZNoFNwWil/ubp0G98nyL4pk/ZhirIiec=;
 b=AGDwILAQ/TLElm5r4aYN6WjB+EPpvhxtI+kM4j2yC6LzHD0v+j1kfwAFlO4qR+McIdcueN
 C0Y+sz1YW/9wsS2a6ijvk+Yh9pOyxvG5Kea67QOHE1vbAzhsmnGguwmOeIDeUmQ8EPL9NW
 s6f4S5IcfIrkOOOmyNEbSyC0ymMYAQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-zN2sO1w4MN2h1t1oAxhBQA-1; Mon, 10 Jan 2022 13:55:38 -0500
X-MC-Unique: zN2sO1w4MN2h1t1oAxhBQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E3A1023F4D;
 Mon, 10 Jan 2022 18:55:37 +0000 (UTC)
Received: from [10.22.8.96] (unknown [10.22.8.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 481018276C;
 Mon, 10 Jan 2022 18:55:36 +0000 (UTC)
Message-ID: <8ef383e2-b34c-6fae-7f60-ae507303b5bd@redhat.com>
Date: Mon, 10 Jan 2022 13:55:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
 <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
 <Ydx+u9YpzS8AZHrl@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Ydx+u9YpzS8AZHrl@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Headers-End: 1n6zpb-0006n9-4s
Subject: Re: [f2fs-dev] [PATCH] f2fs: move f2fs to use reader-unfair rwsems
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
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Tim Murray <timmurray@google.com>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Will Deacon <will@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On 1/10/22 13:45, Peter Zijlstra wrote:
> On Mon, Jan 10, 2022 at 11:18:27AM -0500, Waiman Long wrote:
>> On 1/10/22 03:05, Christoph Hellwig wrote:
>>> Adding the locking primitive maintainers to this patch adding open coded
>>> locking primitives..
>>>
>>> On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
>>>> From: Tim Murray <timmurray@google.com>
>>>>
>>>> f2fs rw_semaphores work better if writers can starve readers,
>>>> especially for the checkpoint thread, because writers are strictly
>>>> more important than reader threads. This prevents significant priority
>>>> inversion between low-priority readers that blocked while trying to
>>>> acquire the read lock and a second acquisition of the write lock that
>>>> might be blocking high priority work.
>>>>
>>>> Signed-off-by: Tim Murray <timmurray@google.com>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> We could certainly implement a down_read() variant (e.g.
>> down_read_lowprio()) with its own slowpath function to do this within the
>> rwsem code as long as there is a good use-case for this kind of
>> functionality.
> I think _unfair() or something along those lines is a *much* better
> naming that _lowprio(). Consider a RT task ending up calling _lowprio().
> That just doesn't make conceptual sense.
I am fine with the _unfair() name as I am not good at naming:-)
>
> And then there's the lockdep angle; the thing being unfair will lead to
> scenarios where lockdep will give a false positive because it expects
> the r-w-r order to block things, which won't happen. A position needs to
> be taken a-prioriy.

Right, we may need to twist lockdep to match the new behavior if we are 
going to provide such a functionality.

Cheers,
Longman



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
