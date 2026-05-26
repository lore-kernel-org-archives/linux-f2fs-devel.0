Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6C6CD5BC8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIGNH517j1PC0KXmEullr00Sb7apMSxgGIoBG7nYLc8=; b=V1P3OaT4SE4ZwyjqzK6vngfQXG
	9/vD6Y4cY5/QP8CeUvkyl73/HBofCBRF0siro7nuVyWF1nJ6Qm0+NWpeR8nGKlQobBgrq0Lk3gX0C
	fA7Aob53gqkQn0rXLxKr6NP00WpFGblsJlm8HEXccK6y/0dejVUii3KdsD0BgB9X//dE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRuR6-0008Tw-0b;
	Tue, 26 May 2026 16:15:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wRuQw-0008Ne-NG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 16:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Anhq5FjNw5ss6qMVPZ01kvuQc5NdyWfGRn2xYsjiF0E=; b=YrMiDlc8SqEgIA8NBG2t9fk9RC
 64WcPXYDYUPmOO6tvdPq64d8YcD7xcVti0iuAgLJ0MPu2QsAVUXttLFLW1v/r8htL1sDT4QodVsrP
 2C82m7szV0Tv0v7sxKSQpt+aqTJeQzuik01J9qYRJDt6v05saEGA8nKsZajnApltIxVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Anhq5FjNw5ss6qMVPZ01kvuQc5NdyWfGRn2xYsjiF0E=; b=X7mXns2Bi959kJ49JYxgSAYr/7
 l2jdbPYVHdZhCa2EsrJR2XXKqHqhG/mKFlxMKKfh3Bdi6UTq0wkF3OSjpSt5uOrh6C08uddPpG5gr
 jAMkAVUVpyd4BA3k986E1TjbEFcPXhlvIuHncHnUsHC+XomfY/Mv/EadUk4pZvMyFK+M=;
Received: from 011.lax.mailroute.net ([199.89.1.14])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRuQs-0002b8-7Q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 16:15:08 +0000
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4gPyWn3BVxz1XM6JN;
 Tue, 26 May 2026 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1779812096; x=1782404097; bh=Anhq5FjNw5ss6qMVPZ01kvuQ
 c5NdyWfGRn2xYsjiF0E=; b=AwiokLBmkPXRDvxv4gU5Q8BxVUMZRQTyw3y+Qzdh
 Z784kR81SRXa82sIkwXcsNyi3LSlK1dqku6rTPoMoPVmLytdqkrK3Yk8LKaof1z5
 IUvPNNPc/Q6S7kOjZkbSrACPm7bjIjgzu1IxxbKBQSlK4tuv38BU7fvs8dD3euDA
 Tw4fggBiI1+wbtfQf2lxAk1Mu/LOduAx3pQdID/Ykhu4h1DH/J12zN1DDyjiiSdq
 XX0cpwgKDWTwyPidFJSdYB7dm+oZ0m3I2dTqtBYofc2bGINuwLNf+Ojxd6k3KQ2K
 xZpeQClWswqs2VOXACuw4RtpJCE1iU/Qha8dSaZmA5A3hg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zKWCJmXtLFCk; Tue, 26 May 2026 16:14:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gPyWd3bBJz1XM5jn;
 Tue, 26 May 2026 16:14:53 +0000 (UTC)
Message-ID: <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
Date: Tue, 26 May 2026 09:14:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Theodore Tso <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <ad30g9xMs9wNJhFb@infradead.org> <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org> <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan> <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan> <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan> <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
Content-Language: en-US
In-Reply-To: <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
X-Headers-End: 1wRuQs-0002b8-7Q
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/26/26 6:42 AM, Theodore Tso wrote:
> It seems... surprising that the additional I/O operations are actually
> throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
> into why this is happening, and whether there is anything that can be
> optimized below the file system?
The layers below the filesystem (block, SCSI, UFS) is what I'm
responsible for in the Pixel team and I can assure you that these are
highly optimized.

Since the transfer size used in Jaegeuk's tests is much larger than 4
KiB, how many CPU cycles are used per IO by the layers below the
filesystem is not limiting the transfer bandwidth.

Bart.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
