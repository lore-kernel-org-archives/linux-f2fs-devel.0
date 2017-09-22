From: "gaoxiang (P)" <gaoxiang25@huawei.com>
Subject: Re: [PATCH] f2fs: allow readpages with NULL file pointer
Date: Fri, 22 Sep 2017 01:54:44 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BBE5BE4@dggemi505-mbs.china.huawei.com>
References: <9047C53C18267742AB12E43B65C7F9F70BBE4BD7@dggemi505-mbs.china.huawei.com>
 <ce60dc40-d2b5-1d89-b050-3314dded93c1@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <gaoxiang25@huawei.com>)
 id 1dvDBN-0002dq-5v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Sep 2017 01:55:09 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dvDBK-0006kG-OZ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Sep 2017 01:55:09 +0000
In-Reply-To: <ce60dc40-d2b5-1d89-b050-3314dded93c1@kernel.org>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao,

Thanks for your reply.
This patch originates from the our sdcardfs compatible case-insensitive lookup acceleration.

For the customized case-insensitive create operation since f2fs has no hash and it needs to decrypt all the dirent name,
it is recommended to read ahead the whole dir data in advance.

However I found f2fs cannot use page_cache_sync_readahead with null @file pointer as the other common Linux file system,
this feature is something like a  bonus and I know that Linux has no written words that we should support null @file pointer, yet
page_cache_sync_readahead is an EXPORT_SYMBOL_GPL and could be used by other non-standard 3rd kernel modules and
of course I think it is really no problem.

Anyway, if it has no use to the community, I will apply it only on the internal branch.
And I will also find some common examples of data page readahead. :)

Thanks,

> -----Original Message-----
> From: Chao Yu [mailto:chao@kernel.org]
> Sent: Thursday, September 21, 2017 10:33 PM
> To: gaoxiang (P) <gaoxiang25@huawei.com>; jaegeuk@kernel.org; Yuchao (T)
> <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: allow readpages with NULL file pointer
> 
> On 2017/9/21 13:00, gaoxiang (P) wrote:
> > Keep in line with the other Linux file system implementations since
> > page_cache_sync_readahead supports NULL file pointer, and thus we can
> > readahead data by f2fs itself without file opening (something like the
> > btrfs behavior).
> 
> Let's keep what it is until there is an example doing readahead passing @file
> with NULL.
> 
> Thanks,
> 
> >
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> >  fs/f2fs/data.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c index 95f30f0..afa12f1
> > 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1333,9 +1333,11 @@ static int f2fs_read_data_pages(struct file *file,
> >  			struct address_space *mapping,
> >  			struct list_head *pages, unsigned nr_pages)  {
> > -	struct inode *inode = file->f_mapping->host;
> > +	struct inode *inode = mapping->host;
> >  	struct page *page = list_last_entry(pages, struct page, lru);
> >
> > +	if (likely(file != NULL))
> > +		BUG_ON(file->f_mapping != mapping);
> >  	trace_f2fs_readpages(inode, page, nr_pages);
> >
> >  	/* If the file has inline data, skip readpages */
> >
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
