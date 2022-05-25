Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5DC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 May 2022 10:15:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nto3B-0000mf-9t; Wed, 25 May 2022 10:15:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nto3A-0000mV-KW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 May 2022 10:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dI8TLOAph7Z3EfK5UcTzDJzKn6DkUwNk5J2wWHxyG6E=; b=OjSsIfLAr5UcWEp26GXVD65tO7
 fYYTxyg7XeVaEeeYXM4e5bEQ6tzY19YTFl3QBDuHdsE4+Eoc71kp/v6yWUE6IKvcUHA3lN6CHiY8n
 VY0esSe8WPy2UTapd6MQWoBHMeTDJfkaib8hJoZ7U2N6LibEPDGehYEC3F27zQXb6k3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dI8TLOAph7Z3EfK5UcTzDJzKn6DkUwNk5J2wWHxyG6E=; b=gly8mh8d1gRxEHMklbe6vIIPXU
 X493FhUI3ZrnquH3A+2zaT7W2Dt/meTOHQlDkF/NkI7g54DGKL4FLJU1UOBm6gL884wZrI3ojgwPk
 dIJ+RcQpBBdYXPHNJJfLv7OFrA0oCis9ZptNqEIQFSZ/oqIjKBnOKiWo+TCnlxaxZtJ0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nto36-008kSo-4U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 May 2022 10:15:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C9263B81D18;
 Wed, 25 May 2022 10:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E5DC385B8;
 Wed, 25 May 2022 10:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653473712;
 bh=dI8TLOAph7Z3EfK5UcTzDJzKn6DkUwNk5J2wWHxyG6E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EVjfMMi6gF+YFccalv0ZyaKU218EGWSLcHHPIfoK/zm79ZEoWs/rO4o+Tb/KDHZ1/
 TPrz79d0g4vlaB2RIfqLk0lL24JUlhG/PPiEHp4sB4EmqRPGE/l4IgmcxtfcV6AC/L
 LQXpkKZXcAMbQnhbJM75VXmNVvDlFa12XTvDIB3hJ43d11jNkSeMLzYldH0wfauUhs
 XsVdcF0oCsOyiAaCsL2BFEIwHq3u96p15zAjQebPyCn9BS/dV5mq9uVweiTAPJ9ta4
 6IrocakkkkeInKzgcEn2Gcd8T+uDZsW8P4wfqizil4JsX06OFdMCbGnMVQrOkZptK1
 6AGPzsB0/31Dw==
Message-ID: <7b3538cb-8886-d766-d510-1eee2ca88292@kernel.org>
Date: Wed, 25 May 2022 18:15:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Yufen Yu <yuyufen@huawei.com>, jaegeuk@kernel.org
References: <20220525094336.2489995-1-yuyufen@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220525094336.2489995-1-yuyufen@huawei.com>
X-Headers-End: 1nto36-008kSo-4U
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: replace F2FS_I(inode) by the local
 variable
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/25 17:43, Yufen Yu via Linux-f2fs-devel wrote:
> We have define 'fi' at the begin of function do_read_inode(),
> just use it, rather than use F2FS_I(inode) again.

How about cleaning up F2FS_I() in other functions, if 'fi' existed?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
