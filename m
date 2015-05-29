From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev]   Not use inline_data  after file shrink
Date: Fri, 29 May 2015 16:14:25 -0700
Message-ID: <20150529231425.GB24511@jaegeuk-mac02.mot.com>
References: <5567F382.5060403@huawei.com>
 <003601d099fd$837394b0$8a5abe10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003601d099fd$837394b0$8a5abe10$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'He YunLei' <heyunlei@huawei.com>, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

[snip]

> > We can see that file still uses 16 Blocks
> > 
> > How do we deal with such situation?
> 
> Now, f2fs does not convert non-inline inode to inline one for these potential
> inodes with small size. So, once inline inode is converted, there is no
> procedure to revert it.
> 
> > it's meaningful to reuse inline_data?
> 
> Actually, I did not know the history reason why we don't implement the
> reverse procedure, as inline_data feature is designed and implemented
> by Huajun and Jaegeuk. I can't find any clues in old threads.

Initial proposal implemented this sort of conversion.
But, in the production level, I suffered from many bugs like eating data.
The major attack to me was the lock coverage which was not fully designed
concretely.

The real complexity lied on allocation and truncation paths in parallel.
And, it turned out the key data structures was not covered by a lock correctly.
So, I changed them not only to use node page lock as much as possible, but
also to implement one-way conversion to reduce lock contention, inline_data
conversion overhead, and code complexity.

In addition, the reason why I decided to do that is from the question how many
large files are converted to small-sized (1B ~ 3.5KB) files.

In terms of life of files, I believe it is enough to set inline_data for
originally small files, which mitigates cleaning overhead as my expectation.

For space utilization, I'm not quite sure since most of space are normally
occupied by many large files for multimedia.

Let me correct, if I'm missing something.

Thanks,
