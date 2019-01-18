From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [4.9-stable] Revert "f2fs: do not recover from previous remained
 wrong dnodes"
Date: Fri, 18 Jan 2019 09:15:25 +0100
Message-ID: <20190118081525.GA7021@kroah.com>
References: <1547753474.3229.184.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547753474.3229.184.camel@codethink.co.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>, stable <stable@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Jan 17, 2019 at 07:31:14PM +0000, Ben Hutchings wrote:
> This fix went into 4.10 and looks like it is needed for the 4.9-stable
> branch:
> 
> commit d47b8715953ad0cf82bb0a9d30d7b11d83bc9c11
> Author: Chao Yu <yuchao0@huawei.com>
> Date:   Sat Nov 5 11:12:40 2016 +0800
> 
>     Revert "f2fs: do not recover from previous remained wrong dnodes"

Now applied, thanks.

greg k-h
