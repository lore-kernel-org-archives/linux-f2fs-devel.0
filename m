From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V2 00/13] Consolidate FS read I/O callbacks
 code
Date: Mon, 29 Apr 2019 17:27:51 -0700
Message-ID: <20190430002751.GB13796@bombadil.infradead.org>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1hLGcq-0006OF-1b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Apr 2019 00:28:00 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hLGco-001xjA-FO
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Apr 2019 00:27:59 +0000
Content-Disposition: inline
In-Reply-To: <20190428043121.30925-1-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.ibm.com>
Cc: hch@infradead.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Sun, Apr 28, 2019 at 10:01:08AM +0530, Chandan Rajendra wrote:
> With these changes in place, the patchset changes Ext4 to use
> mpage_readpage[s] instead of its own custom ext4_readpage[s]()
> functions. This is done to reduce duplicity of code across

FYI, "duplicity" means "lying".  You meant "duplication".
