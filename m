Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3AAC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jan 2022 16:18:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n6xNc-0001XO-5I; Mon, 10 Jan 2022 16:18:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <longman@redhat.com>) id 1n6xNZ-0001XE-Vr
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 16:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZD+LOj5cUuiivVEnNNCtusx2ZUVNWQVbTXyULr5z3N0=; b=RI0LvNOsZ5oY013dSwxfk2vKsx
 PMwS+HCXOE9Nvu0d2eJISyN1wF427jmhS6KmjQowmFqFzXFCHGMXgGBCYwhAg17/61NDhdn2ca+tM
 NYvCTmCyTU6dhakf/wiKIutVSC9YBJkLrLNNDNA+2kHuSksRQcxVnkH/DFCXpUrvBEcQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZD+LOj5cUuiivVEnNNCtusx2ZUVNWQVbTXyULr5z3N0=; b=dsgskYaB1Oi4O4oKKpAtMqB/In
 ei3xqPscDYr1BMHzi/zZmLtyqWu4whLs65fako82r7wYaxWcvI8y4Xp+8VdRu0qJsS1Pc0VPK7uvG
 U0a7tmqcpxl64UHxCu6vTm71Wmq0dBuC1PTT0jvbeAOdmaWfEyo61ROSaH1OaLtj4zzc=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n6xNX-00AeJV-6l
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jan 2022 16:18:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641831513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZD+LOj5cUuiivVEnNNCtusx2ZUVNWQVbTXyULr5z3N0=;
 b=Ufp+Jf4bYOdsKBFelxHDI7al5wrYq2rlaTqgyd/Pdd0cUdnl3cRxTTNWcG/7Yxc/FnZjQs
 MgQTHWY1OEZUx4Z+H7R6VQaaT2dviqSLTxQUJrNhE5+8b1P4/n/ILBUGLybQU9ToOFRq2W
 zbPs6Rh4/DvzFD5Sh4kDXowcWtLRE2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-XXSAueLMOjm4oOkgxkxvaQ-1; Mon, 10 Jan 2022 11:18:29 -0500
X-MC-Unique: XXSAueLMOjm4oOkgxkxvaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88810839A44;
 Mon, 10 Jan 2022 16:18:28 +0000 (UTC)
Received: from [10.22.11.34] (unknown [10.22.11.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86B047E8C8;
 Mon, 10 Jan 2022 16:18:27 +0000 (UTC)
Message-ID: <a23a3226-95d9-9835-c1c7-2d13f4a1ee16@redhat.com>
Date: Mon, 10 Jan 2022 11:18:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220108164617.3130175-1-jaegeuk@kernel.org>
 <YdvoxkAAquI17UbX@infradead.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <YdvoxkAAquI17UbX@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Headers-End: 1n6xNX-00AeJV-6l
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
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On 1/10/22 03:05, Christoph Hellwig wrote:
> Adding the locking primitive maintainers to this patch adding open coded
> locking primitives..
>
> On Sat, Jan 08, 2022 at 08:46:17AM -0800, Jaegeuk Kim wrote:
>> From: Tim Murray <timmurray@google.com>
>>
>> f2fs rw_semaphores work better if writers can starve readers,
>> especially for the checkpoint thread, because writers are strictly
>> more important than reader threads. This prevents significant priority
>> inversion between low-priority readers that blocked while trying to
>> acquire the read lock and a second acquisition of the write lock that
>> might be blocking high priority work.
>>
>> Signed-off-by: Tim Murray <timmurray@google.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

We could certainly implement a down_read() variant (e.g. 
down_read_lowprio()) with its own slowpath function to do this within 
the rwsem code as long as there is a good use-case for this kind of 
functionality.

Cheers,
Longman



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
