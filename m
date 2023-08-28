Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EE8C83F12
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Aug 2023 14:02:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qacoz-0003dQ-NA;
	Mon, 28 Aug 2023 14:02:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <viro@ftp.linux.org.uk>) id 1qacoy-0003dK-69
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 14:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EoGjlAqIr84+dzTRIVSh6MnXuXBwrPpcJyhAY3N5ock=; b=AmC9TFfZhJMEmsncmb5S07LXwO
 1PDvl66hqsD91TH75OLD5kkunTv0waMTFzc6pp5ufAKwBnD8V1dpF4jF5IS1JNy0w7u53yKc4JSj6
 NzCpAotKkkSixYj6ZR697lWp6eyvFyGClAfC3MPkCgWEg3AOlfjXfEKCIr84jIZ7m+MY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EoGjlAqIr84+dzTRIVSh6MnXuXBwrPpcJyhAY3N5ock=; b=eWX51xPICdzmEM8zyaMs7DM74E
 bwvCrhFehTN2ZvYbOXk1k9avItHBikbQ3RTFX/6bMH5IkTwLxCPTB7K72Xo3SzcG4bXTkk8ZwYw00
 gfCMqKJLxiHkWW5fhmLud6PmJa5tqQNCbXsS9Klh6g9v8VnXkE6XzsBef7fCTt7Sk9Q8=;
Received: from zeniv.linux.org.uk ([62.89.141.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qacoy-000oHU-B4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Aug 2023 14:02:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EoGjlAqIr84+dzTRIVSh6MnXuXBwrPpcJyhAY3N5ock=; b=Cys3/JAywwflbjKeLLbxLR4Pml
 1ZIuH88594x0nLpO6iJLXX9l6sI1h8ZkRVdCon46JySP7xwVSIy6uJlVUPCBG0I1jMUBp/0W9K9uT
 GCXP/OFE+JrmC3Pa+vZcLym98yS0JgfF9SpK8F8b18qNPjfvCtYSzNZ2k1S35WDywJTHF23uRdIPl
 X360jIARja8/zh1+SEIlBXc4nXvwCf4DxcPHjnlmChlDL/j2yB9CBDj1MRvDfFoTePW35BIjZXSeZ
 oEnIi346oyjWFuEc9Uk6usuZ2p/gFgmA/OPtZ8mAicao0VPMQqLBW8+t2E5sM608aGZst3O1yE7EK
 cxVGuQGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qacoc-001ZYo-2Z; Mon, 28 Aug 2023 14:02:03 +0000
Date: Mon, 28 Aug 2023 15:02:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230828140202.GX3390869@ZenIV>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV> <20230828123023.GA11084@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230828123023.GA11084@lst.de>
X-Headers-End: 1qacoy-000oHU-B4
Subject: Re: [f2fs-dev] [PATCH 03/12] filemap: update ki_pos in
 generic_perform_write
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 28, 2023 at 02:30:23PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 27, 2023 at 08:41:22PM +0100, Al Viro wrote:
> > That part is somewhat fishy - there's a case where you return a positive value
> > and advance ->ki_pos by more than that amount.  I really wonder if all callers
> > of ->write_iter() are OK with that.  Consider e.g. this:
> 
> This should not exist in the latest version merged by Jens.  Can you
> check if you still  see issues in the version in the block tree or
> linux-next.

Still does - the problem has migrated into direct_write_fallback(), but
that hadn't changed the situation.  We are still left with ->ki_pos bumped
by generic_perform_write() (evaluated as an argument of direct_write_fallback()
now) and *not* retraced in case when direct_write_fallback() decides to
discard the buffered write result.  Both in -next and in mainline (since
6.5-rc1).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
