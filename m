From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 2/5] ext4: cache NULL when both
 default_acl and acl are NULL
Date: Sat, 6 Oct 2018 23:36:45 -0400
Message-ID: <20181007033645.GA12046@thunk.org>
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-2-cgxu519@gmx.com>
 <f1dd02a3-78ea-0240-72cc-135ee26f6524@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <f1dd02a3-78ea-0240-72cc-135ee26f6524@gmx.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: cgxu519 <cgxu519@gmx.com>
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net, martin@omnibond.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca, jack@suse.com, jaegeuk@kernel.org, linux-ext4@vger.kernel.org, devel@lists.orangefs.org, hubcap@omnibond.com

On Wed, Sep 12, 2018 at 11:04:35PM +0800, cgxu519 wrote:
> On 08/31/2018 10:33 PM, Chengguang Xu wrote:
> > default_acl and acl of newly created inode will be initiated
> > as ACL_NOT_CACHED in vfs function inode_init_always() and later
> > will be updated by calling xxx_init_acl() in specific filesystems.
> > Howerver, when default_acl and acl are NULL then they keep the value
> > of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
> > in this case.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Applied, thanks.

						- Ted
