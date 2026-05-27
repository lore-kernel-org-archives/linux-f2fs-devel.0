Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86655CD5BD2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jerG/h0hlQAb2AXoVNezDisNevv2OS+hT38JeKdC5dc=; b=E8h3o1oWB2QTO5GcsiFPY7WB0y
	AVkss2PMKHV4tryttdtJkYN2pdtr2fxMbAiPPHYuxcyFE6hcB15KIkZ6IpORNpoafWDr3bxUU2bCz
	CIX1DnTQj5ob196m52ZxOaPZCpdbPjma//db/xF/Ab48gdEN71rYgBnik/OX/7+bNg3E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wS2sB-0005Kr-2I;
	Wed, 27 May 2026 01:15:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wS2s3-0005Kf-W7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 01:15:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JQ76c0ZKyPhJJ/YX2rWxuedO/ZUKDUPRSCpouDt6Lvk=; b=Bv8VJ7VHHVH4zfGZpVx7Ji2ZJ8
 FPjtlmQCKiuYaeR4dQeQmjEr3uAu8l2nvZNUZ3wDn2yVLoZ7OsD7udj88pTTs7HvJRZYsB1b30uEU
 Dg46oWb8NqCwkUnAI7MbU1DYVcfHMUdITqke9Av221uKv64pdVhHfu4MW47vWIxHiJkE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JQ76c0ZKyPhJJ/YX2rWxuedO/ZUKDUPRSCpouDt6Lvk=; b=UZvFaEU52Q8PkJYv2QeydF+TII
 MyGmEPD1Im1LNItZnJaYG4P+hR/a/SJxs2iQRK7806t09MXjksjrERvpQ0jkL30v4CpIVb5Ncb9ch
 tL0+Hn4LRFZ1Rt4s4UNcYYgdp0xpljKjkDrhzc8cdrOAp6yvH1sd0pAxQjUUoAF8e1gk=;
Received: from 011.lax.mailroute.net ([199.89.1.14])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS2s1-0000T1-Gk for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 01:15:44 +0000
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4gQBWX66T0z1XM6JN;
 Wed, 27 May 2026 01:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1779844532; x=1782436533; bh=JQ76c0ZKyPhJJ/YX2rWxuedO
 /ZUKDUPRSCpouDt6Lvk=; b=4dszTYjTwYxVzsK3EmW9I1eIh8cJav0Zmg4Fqfhk
 n7ad5S6m0qtboA6aELUUHk0Bmf9+W+j9opNIKiyfk+bC8Qb3Lc/nlkD6vyRe7wbU
 fXwsGcFzjzm5rIS+FgdgCByEX5IkJjGK/eM5WbcxqUIPjply4pF982/b8uKeH2Sh
 NtvGWCfKMItmhtUqIWNcJA9I0Oqq8n24Tdfm5M21Bq8fdB0ib+LQ4dubSg1na0/N
 PjQDFLtOr//BL6iWNAADp4KO4TYgmtmUVYssbrqlz0ZhMD/NL85WOqkHPRnKa3i8
 1QaFn9ew0mcDMHLGW25DZQucxmLe2nKCKbCEQFJaJYlaTw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MBCftocQcW0H; Wed, 27 May 2026 01:15:32 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net
 [73.231.117.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gQBWM5yz8z1XM5jn;
 Wed, 27 May 2026 01:15:27 +0000 (UTC)
Message-ID: <426a9687-c39e-4ac8-a406-d5e2198f01b0@acm.org>
Date: Tue, 26 May 2026 18:15:24 -0700
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
X-Headers-End: 1wS2s1-0000T1-Gk
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
>      2. Host Controller Hardware Limits (UFSHCI)
>      
> 	Transfer Queue Depth: A UFS controller supports a predefined
> 	    number of outstanding task request entries. This is often
> 	    hard-capped at 32 concurrent transfer requests (slots) by the
> 	    doorbell register array.

The above information comes from the UFSHCI 3 standard. Jaegeuk's test
setup has an UFSHCI 4.0 controller that supports one submission queue
per CPU and also one completion queue per CPU. This is an architecture
that is very similar but not identical to NVMe. Jaegeuk, please correct
me if I got anything wrong.

Bart.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
